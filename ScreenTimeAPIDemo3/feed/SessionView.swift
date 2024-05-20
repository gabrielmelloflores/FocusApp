import SwiftUI
import FamilyControls

struct SessionView: View {
    @StateObject var model = FamilyControlModel.shared
    @State var isPresented = false
    @State private var selectedDuration: Int = 15
    @State private var blockUntil = Date()
    @State private var isChoosingApps = false
    @State private var timeRemaining: Int = 0
    @State private var sessionActive = false
    @State private var timer: Timer? = nil

    let durations = [1, 15, 30, 45, 60]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    if sessionActive {
                        Section(header: Text("Session in Progress").foregroundColor(.white)) {
                            Text("Time Remaining: \(timeString(time: timeRemaining))")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                        }
                    } else {
                        Section(header: Text("Focus Session").foregroundColor(.white)) {
                            HStack {
                                Text("Duration")
                                Spacer()
                                Picker("Duration", selection: $selectedDuration) {
                                    ForEach(durations, id: \.self) { duration in
                                        Text("\(duration) minutes").tag(duration)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .foregroundColor(.gray)
                            }
                            .contentShape(Rectangle())

                            HStack {
                                Text("Choose Apps to Block")
                                Spacer()
                                Button(action: {
                                    Task {
                                        try await model.authorize()
                                        isPresented = true
                                    }
                                }) {
                                    Text("Choose Apps")
                                        .foregroundColor(.blue)
                                }
                                .familyActivityPicker(isPresented: $isPresented, selection: $model.selectionToDiscourage)
                            }
                            .contentShape(Rectangle())
                        }

                        HStack {
                            Text("There will be increasing delays before you can snooze again")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }

                        Button(action: {
                            startBlockingSession()
                        }) {
                            Text("Start Session")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                        }
                        .listRowBackground(Color.green)
                        .fontDesign(.rounded)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Focus Session")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(Color.black.edgesIgnoringSafeArea(.all)) // Fundo preto
            .colorScheme(.dark) // Aplica o modo escuro
        }
        .accentColor(.white) // Change navigation bar item color
    }

    private func startBlockingSession() {
        let now = Date()
        blockUntil = Calendar.current.date(byAdding: .minute, value: selectedDuration, to: now)!
        timeRemaining = selectedDuration * 60
        sessionActive = true

        model.scheduleBlocking(startingFrom: now, endingAt: blockUntil)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                sessionActive = false
                timer?.invalidate()
                model.encourageAll()
            }
        }
    }

    private func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
    }
}
