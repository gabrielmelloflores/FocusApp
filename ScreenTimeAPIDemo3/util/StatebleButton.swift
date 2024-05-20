import SwiftUI

struct StatebleButton<Content>: ButtonStyle where Content: View {
    var change: (Bool) -> Content
    
    func makeBody(configuration: Configuration) -> some View {
        return change(configuration.isPressed)
    }
}
