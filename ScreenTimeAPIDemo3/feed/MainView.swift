
import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Blocks")
                        .font(.title)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()

                VStack(spacing: 20) {
                    ForEach(BlockData.allBlocks) { block in
                        BlockCardView(title: block.title, subtitle: block.subtitle)
                    }
                }
                Spacer()
            }
        }
    }
}

struct BlockCardView: View {
    let title: String
    let subtitle: String
    @State private var showingModal = false
    @State private var selectedView: AnyView?
    
    var body: some View {
        Button(action: {
            self.showingModal = true
            self.selectedView = self.getView(for: title)
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
        }
        .halfSheet(showsHalfModal: $showingModal) {
            if let selectedView = selectedView {
                selectedView
            } else {
                EmptyView()
            }
        }
   }
    
    private func getView(for title: String) -> AnyView {
        switch title {
        case "My App Limit":
            return AnyView(BlockView())
        case "Work Time":
            return AnyView(SessionView())
        default:
            return AnyView(EmptyView())
        }
    }
}

extension View {
    func halfSheet<SheetView: View>(showsHalfModal: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        return self
            .background(
                HalfModalHelper(sheetView: sheetView(), showsHalfModal: showsHalfModal)
            )
    }
}

struct MyHalfModalView: View {
    var body: some View {
        // Personalize a sua vista de modal
        VStack {
            Text("My App Limit")
                .font(.title)
                .foregroundColor(.white)
            // Restante do seu conteúdo
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(Color.gray.opacity(0.5))
    }
}

struct HalfModalHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showsHalfModal: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if showsHalfModal {
            let sheetController = CustomHostingController(rootView: sheetView)
            uiViewController.present(sheetController, animated: true) {
                DispatchQueue.main.async {
                    self.showsHalfModal = false
                }
            }
        }
    }

    typealias UIViewControllerType = UIViewController
}

class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()] // Set the height here
            presentationController.prefersGrabberVisible = true
        }
    }
}

struct BlockData: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String

    static let allBlocks = [
        BlockData(title: "My App Limit", subtitle: "15 minutes limit, Weekdays"),
        BlockData(title: "Work Time", subtitle: "Weekdays, 7:30 - 23:00")
    ]
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
