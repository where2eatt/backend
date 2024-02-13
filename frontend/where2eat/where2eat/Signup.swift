//
//  Signup.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct Signup: View {
    @State private var username = ""
    @State private var password = ""
    @State private var reenter = ""
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center) {
                
                Text("SIGN UP")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
            
                
                TextField("Create Username", text: $username)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .border(Color.gray, width: 1)
                    .padding()
                
                SecureField("Create Password", text: $password)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .border(Color.gray, width: 1)
                    .padding()
                
                SecureField("Re-enter Password", text: $reenter)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .border(Color.gray, width: 1)
                    .padding()
                
                
                Button("SIGN UP") {
                    
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 50)
                
//                Button("SIGN UP WITH GOOGLE") {
//                    
//                }
//                
//                .font(.title2)
//                .buttonStyle(.borderedProminent)
//                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
//                .frame(width: 250, height: 100)
                
//                Button("SIGN UP WITH APPLE ACOUNT") {
//                    
//                }
//                
//                .font(.title2)
//                .buttonStyle(.borderedProminent)
//                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
//                .frame(width: 250, height: 100)


            }
        }
    }
    
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}


