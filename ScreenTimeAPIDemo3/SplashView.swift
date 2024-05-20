//
//  SplashView.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728 on 4/21/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            ContentView().preferredColorScheme(.light)
        } else {
            ZStack {
                Color("main").ignoresSafeArea()
                
                VStack {
                    VStack {
                        Image("splashIcon")
                            .resizable()
                            .frame(width: 75, height: 150)
                        
                        /*Text("Focus")
                            .foregroundStyle(Color(.white))
                            .font(Font.custom("ChalkboardSE-Bold", size: 26))*/
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.00
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
