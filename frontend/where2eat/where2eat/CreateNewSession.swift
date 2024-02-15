//
//  CreatreNewSession.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct CreateNewSession: View {
    @State private var num = ""
    @State private var date = ""
    @State private var time = ""
    @State private var event = ""
    @State private var isCalendarViewPresented = false

    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center) {
                Text("CREATE A NEW SESSION")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(30)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Text("ATTENDEE #")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Enter Number of Attendees", text: $num)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("DATE RANGE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Enter Date Range", text: $date)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("TIME RANGE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Enter Time Range", text: $time)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                    
                }
                
                HStack {
                    Text("EVENT TYPE")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Enter Event Type", text: $event)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                Button("GENERATE SESSION NEW LINK") {
                    isCalendarViewPresented = true
                }
            }
        }
        .sheet(isPresented: $isCalendarViewPresented) {
            Calendar()
        }
    }
}

struct CreateNewSession_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewSession()
    }
}

