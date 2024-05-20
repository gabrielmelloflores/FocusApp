//
//  ProfileView.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Image("personIcon")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 10)
                    .padding(.top, 50)
                
                Text("Gabriel Flores")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                Text("gabriel@email.com")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
                
                Spacer()
                
                Button(action: {
                    // Ação do botão
                    print("Editar perfil clicado")
                }) {
                    Text("Editar")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 140, height: 50)
                        .background(Color.gray)
                        .cornerRadius(25)
                        .shadow(radius: 10)
                }
                .padding(.bottom, 40)
                
                
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
