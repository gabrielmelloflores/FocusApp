
import SwiftUI

struct LoginScreen: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("imageFundo")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)

                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    
                    Image(systemName: "lock.shield")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .padding(.bottom, 50)
                    
                    VStack(spacing: 16) {
                        TextField("Username", text: $viewModel.username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)
                            .shadow(radius: 3)
                        
                        SecureField("Password", text: $viewModel.password)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(8)
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    Button("Login", action: viewModel.login)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .navigationDestination(isPresented: $viewModel.isLoggedIn) {
                ContentView() // Navega para ContentView quando logado
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
