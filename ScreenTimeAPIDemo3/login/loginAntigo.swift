
//
//  LoginScreen.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728.
//

import SwiftUI

struct LoginAntigoScreen: View {
    
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack {
                TextField(
                    "Username",
                    text: $viewModel.username
                )
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding(.top, 20)
                .background(Color(.white))
                
                Divider()
                
                SecureField(
                    "Password",
                    text: $viewModel.password
                )
                .padding(.top, 20)
                .background(Color(.white))
                
                Divider()
            }
            
            Spacer()
            
            Button(
                action: viewModel.login,
                label: {
                    Text("Login")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundColor(Color.white)
                        .background(Color(.accent))
                        .cornerRadius(10)
                }
            )
        }
        .padding(30)
        .background(Color(.main))
    }
}

struct LoginAntigoScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginAntigoScreen()
    }
}
