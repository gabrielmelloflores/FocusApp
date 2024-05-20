//
//  mainContent.swift
//  ScreenTimeAPIDemo3
//
//  Created by user256728
//

import SwiftUI
import FamilyControls

struct mainContent: View {
     @State var isPresented = false
    @State private var blockFrom = Date()
    @State private var blockUntil = Date()
    
    var body: some View {
        ZStack {
            Color("accent").ignoresSafeArea()
            VStack(spacing:40) {
                
                
                Button("Select Apps to Block") {
                    Task {

                        isPresented = true
                    }
                }

                .padding()
                
                DatePicker("Block From:", selection: $blockFrom, in: Date()..., displayedComponents: .hourAndMinute)
                    .padding()
                
                DatePicker("Block Until: ", selection: $blockUntil, in: Date()..., displayedComponents: .hourAndMinute)
                    .padding()
                
                Button("Set Blocking"){

                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
