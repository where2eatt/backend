//
//  Chatroom.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct Chatroom: View {
    @State private var chat = ""
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center) {
                
                Text("CHATROOM")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
            Spacer()

                TextField("Send a message", text: $chat)
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .border(Color.gray, width: 1)
                    .padding()
            }
        }
    }
}

struct Chatroom_Previews: PreviewProvider {
    static var previews: some View {
        Chatroom()
    }
}
