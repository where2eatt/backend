import SwiftUI
import UIKit

struct Home: View {

    @State private var selectedView: String = "Sessions"
    
    var body: some View {
        ZStack {
            VStack (alignment: .center, spacing: 20.0) {
                if selectedView == "Sessions" {
                    Sessions()
                } else if selectedView == "CreateNewSession" {
                    CreateNewSession()
                } else if selectedView == "Chatroom" {
                    Chatroom()
                }
              
                Rectangle()
                    .fill(Color(red: 1, green: 1, blue: 0))
                    .frame(height: 60)
                    .overlay(
                        NavigationView {
                            HStack {
                                Spacer()
                                Button(action: {
                                    selectedView = "Sessions"
                                }) {
                                    Image("house")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .colorInvert()
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedView = "CreateNewSession"
                                }) {
                                    Image("plus")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .colorInvert()
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedView = "Chatroom"
                                }) {
                                    Image("text.bubble")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .colorInvert()
                                }
                                Spacer()
                            }
                        }
                    )
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


