//
//  ContentView.swift
//  where2eat

//

import SwiftUI
import UIKit

struct ChooseSession: View {
    @State private var navigateToASession = false
    @State private var isHistoryPage = false
    @State private var currentsession = false
    @State private var createsession = false
    @State private var joinsession = false
    @AppStorage("sessionId") var storedSessionId: String = ""

    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                
                Text("SESSIONS")
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
                
                Button("CURRENT SESSIONS") {
                    currentsession = true
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 50)

                Button("JOIN SESSION") {
                    joinsession = true
                    storedSessionId = ""
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                .frame(width: 250, height: 50)
                
                
                Button("CREATE A NEW SESSION") {
                    createsession = true
                }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                    .frame(width: 250, height: 70)
                
                .sheet(isPresented: $createsession) {
                    CreateNewSession()
                }
                .sheet(isPresented: $joinsession) {
                    JoinSession()
                }
                .fullScreenCover(isPresented: $currentsession) {
                    Home()
                }
            }
        }
    }
    
}

struct ChooseSession_Previews: PreviewProvider {
    static var previews: some View {
        ChooseSession()
    }
}


