//
//  CreatreNewSession.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct CreateNewSession: View {
    @State private var text = ""
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                
                Text("CREATE A NEW SESSION")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                    .multilineTextAlignment(.center)
                Spacer()
                
                HStack {
                    Text("ATTENDEE #")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(30.0)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter Number of Attendees", text: $text)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("DATE RANGE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(30.0)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter Number of Attendees", text: $text)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("TIME RANGE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(30.0)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter Number of Attendees", text: $text)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("EVENT TYPE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(30.0)
                        .multilineTextAlignment(.center)
                    
                    TextField("Enter Number of Attendees", text: $text)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                Button("GENERATE SESSION NEW LINK") {
                    
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
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

struct CreateNewSession_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewSession()
    }
}

