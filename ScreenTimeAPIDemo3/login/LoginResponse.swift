//
//  LoginResponse.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728 .
//


import Foundation

struct LoginResponse: Decodable {
    let data: LoginResponseData
}

struct LoginResponseData: Decodable {
    let accessToken: String
    let refreshToken: String
}
