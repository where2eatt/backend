//
//  CreatreNewSession.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct ASession: View {
    @State private var navigateToChatroom = false
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center) {
                Text("DINNER WITH 403 GROUP")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(30)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Text("ATTENDEE #:")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("5")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                }
                
                HStack {
                    Text("DATE:")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("FEB 29TH, 2024")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                
                HStack {
                    Text("TIME RANGE:")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("6:30 PM - 7:30 PM")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    
                }
                
                HStack {
                    Text("LOCATION:")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Text("ARAYA'S PLACE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                
                
                Button("GO TO GROUP CHAT") {
                    navigateToChatroom = true
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
                .sheet(isPresented: $navigateToChatroom) {
                    Chatroom()
                }
            }
        }
    }
    
    struct ASession_Previews: PreviewProvider {
        static var previews: some View {
            ASession()
        }
    }
}
