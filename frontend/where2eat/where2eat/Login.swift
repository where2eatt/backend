//
//  Login.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct Login: View {
    @State private var text = ""
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center) {
                
                
                Text("LOG IN")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                Spacer()
                
                TextField("Enter Username", text: $text)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .border(Color.gray, width: 1)
                    .padding()
                
                TextField("Enter Password", text: $text)
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
                
                Button("LOG IN WITH GOOGLE") {
                    
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 100)
                
                Button("LOG IN WITH APPLE ACCOUNT") {
                    
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 100)
                
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}


