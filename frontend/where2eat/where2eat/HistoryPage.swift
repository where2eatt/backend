//
//  HistoryPage.swift
//  where2eat
//
//  Created by stlp on 3/5/24.
//

import SwiftUI
import UIKit

struct HistoryPage: View {
    @State private var isShowingLogin = false
    @State private var isShowingSignup = false
    @State private var isGoingToSessions = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 1, green: 1, blue: 0.9254901960784314)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .center, spacing: 20.0) {
                    Text("Location History")
                        .font(.title)
                        .font(.custom("Roboto", size: 26))
                        .fontWeight(.bold)
                        .padding(40)
                    
                    Button("Went to Taco Bell with Roomates with 12/9/2021") {
                
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)

                    
                    Button("Went to Little Thai with parents on 1/1/2022") {
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)
                    
                    Button("Go to Sessions") {
                        isGoingToSessions = true
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 100)

                    
                    
                    .sheet(isPresented: $isShowingLogin) {
                        Login()
                    }
                    .sheet(isPresented: $isShowingSignup) {
                        Signup()
                    }
                    .sheet(isPresented: $isGoingToSessions) {
                        Sessions()
                    }
                }
            }
        }
    }
}

struct HistoryPage_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

