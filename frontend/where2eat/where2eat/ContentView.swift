//
//  ContentView.swift
//  where2eat
//
//  Created by Adrien Delepine on 1/30/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
        var body: some View {
            ZStack {
                Color(red: 1, green: 1, blue: 0.9254901960784314)
                    .ignoresSafeArea()
                
                VStack (alignment: .center, spacing: 20.0) {
//                    .background(Rectangle() .foregroundColor(.white))
                    Text("MY SESSIONS")
                        .font(.title)
                    
                    Button("Dinner with CSE 403 Group") {
            
                    }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    
                    Spacer()
                    
                    HStack {
                        Image("home")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        
                        Image("plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        
                        Image("chat")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                    }
                }
            }
            .padding()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

