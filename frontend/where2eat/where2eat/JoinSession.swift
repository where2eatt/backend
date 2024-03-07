//
//  CreatreNewSession.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct JoinSession: View {
    @State private var isCalendarViewPresented = false
    @AppStorage("sessionId") var storedSessionId: String = ""

    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                .edgesIgnoringSafeArea(.all)

            VStack (alignment: .center) {
                Text("JOIN A SESSION")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(30)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                HStack {
                    Text("SESSION ID")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    TextField("Enter Session ID", text: $storedSessionId)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()

                }

                Button("NEXT") {
                    isCalendarViewPresented = true
                }
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))

                .sheet(isPresented: $isCalendarViewPresented) {
                    Calendar()
                }

            }
        }
        .sheet(isPresented: $isCalendarViewPresented) {
            Calendar()
        }
    }
}

struct JoinSession_Previews: PreviewProvider {
    static var previews: some View {
        JoinSession()
    }
}

