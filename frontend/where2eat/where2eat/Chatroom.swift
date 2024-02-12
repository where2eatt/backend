//
//  Chatroom.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct Chatroom: View {

    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                
                Text("CHATROOM")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                Spacer()
                
                Rectangle()
                    .fill(Color(red: 0.9607843137254902, green: 0.9607843137254902, blue: 0.9607843137254902))
                    .frame(height: 200)
                
                    .overlay(
                        HStack {
                            Image("home")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .padding()
                            
                            Image("plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                                .padding()
                            
                            Image("chat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90)
                                .padding()
                        }
                    )
            }
        }
    }
    
}

struct Chatroom_Previews: PreviewProvider {
    static var previews: some View {
        Chatroom()
    }
}
