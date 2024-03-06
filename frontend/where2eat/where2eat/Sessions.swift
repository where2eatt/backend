//
//  ContentView.swift
//  where2eat
//
//  Created by Adrien Delepine on 1/30/24.
//

import SwiftUI
import UIKit

struct Sessions: View {
    @State private var navigateToASession = false
    @State private var isHistoryPage = false


    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                
                Text("MY SESSIONS")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
                
                Button("PAST SESSIONS") {
                    isHistoryPage = true
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 50)
                .fullScreenCover(isPresented: $isHistoryPage) {
                    HistoryPage()
                }
                
                Button("DINNER WITH CSE 403 GROUP") {
                    navigateToASession = true
                }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                    .frame(width: 250, height: 70)
                
                    .sheet(isPresented: $navigateToASession) {
                        ASession()
                    }
            }
        }
    }
    
}

struct Sessions_Previews: PreviewProvider {
    static var previews: some View {
        Sessions()
    }
}

