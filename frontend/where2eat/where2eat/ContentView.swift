//
//  Home.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var isShowingLogin = false
    @State private var isShowingSignup = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(red: 1, green: 1, blue: 0.9254901960784314)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .center, spacing: 20.0) {
                    
                    Text("WHERE2EAT")
                        .font(.title)
                        .font(.custom("Roboto", size: 26))
                        .fontWeight(.bold)
                        .padding(40)
                    
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                        .padding()
                    
                    Button("LOG IN") {
                        isShowingLogin = true
                    }
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 300, height: 50)

                    
                    Button("SIGN UP") {
                        isShowingSignup = true
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
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
