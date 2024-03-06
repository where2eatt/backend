//
//  HistoryPage.swift
//  where2eat
//
//  Created by stlp on 3/5/24.
//

import SwiftUI
import UIKit

struct HistoryPage: View {
    @State private var isGoingToSessions = false
    @State private var selectedView: String = "Sessions"

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1, green: 1, blue: 0.9254901960784314)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .center, spacing: 20.0) {
                    Text("LOCATION HISTORY")
                        .font(.title)
                        .font(.custom("Roboto", size: 26))
                        .fontWeight(.bold)
                        .padding(40)
                    
                    Button("TACO BELL WITH ROOMATES (12/09/2021)") {
                
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)

                    
                    Button("LITTLE THAI WITH PARENTS (01/01/2022)") {
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)
                    
                    Button("MY SESSIONS") {
                        isGoingToSessions = true
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)

                    
                    .sheet(isPresented: $isGoingToSessions) {
                        Home()
                    }
                }
            }
        }
    }
}

struct HistoryPage_Preview: PreviewProvider {
    static var previews: some View {
        HistoryPage()
    }
}

