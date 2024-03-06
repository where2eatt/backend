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

        
        // Function to handle the session creation
        func createSession() {
            // Define the URL for the POST request
            
            guard let url = URL(string: Constants.apiGatewayUrl + "/session") else {
                print("Invalid URL")
                return
            }
            
            // Create the request body
            let body: [String: String] = [
                "username": "user1",
                "location": "seattle"
            ]
            
            // Convert the body to JSON data
            guard let jsonData = try? JSONSerialization.data(withJSONObject: body) else {
                print("Failed to serialize JSON data")
                return
            }
            
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            // Send the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the response
                if let data = data {
                    // Parse the response JSON
                    if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                        // Update UI based on the response
                        DispatchQueue.main.async {
                            if let sessionId = json["sessionId"], let sessionHostUsername = json["sessionHostUsername"] {
                                print("Session ID: \(sessionId)")
                                print("Session Host Username: \(sessionHostUsername)")
                            } else {
                                print("Invalid response format")
                            }
                        }
                    } else {
                        print("Invalid JSON response")
                    }
                } else {
                    print("No data received")
                }
            }.resume()
        }
    
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

struct CreateNewSession_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewSession()
    }
}

