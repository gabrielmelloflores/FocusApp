//
//  ContentView+.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728 on 4/21/24.
//

import SwiftUI

extension ContentView {

    func CustomTabItem(iconName: String, isActive: Bool) -> some View {
        ZStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(isActive ? Color(.accent) : .white)
        }
    }
}
