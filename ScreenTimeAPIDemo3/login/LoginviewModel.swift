//
//  LoginViewModel.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728.
//


import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    
    func login() {
        // Login fixo para testes
        if username == "admin" && password == "admin" {
            print("Login successful")
            isLoggedIn = true  // Navega para a tela Home
        } else {
            print("Login failed")
            isLoggedIn = false
        }
    }
}
