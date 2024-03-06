//
//  Signup.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

struct Signup: View {
    @State private var username = ""
    @State private var password = ""
    @State private var reenter = ""
    @State private var navigateToHome = false
    @State private var showErrorAlert = false
    @AppStorage("username") var storedUsername: String = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 1, green: 1, blue: 0.9254901960784314)
                    . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack (alignment: .center) {
                    
                    Text("SIGN UP")
                      .font(.title)
                      .font(.custom("Roboto", size: 26))
                      .fontWeight(.bold)
                      .padding(40)
                
                    
                    TextField("Create Username", text: $username)
                      .autocapitalization(.none)
                      .multilineTextAlignment(.center)
                      .font(.title)
                      .border(Color.gray, width: 1)
                      .padding()
                    
                    SecureField("Create Password", text: $password)
                      .autocapitalization(.none)
                      .multilineTextAlignment(.center)
                      .font(.title)
                      .border(Color.gray, width: 1)
                      .padding()
                    
                    SecureField("Re-enter Password", text: $reenter)
                      .autocapitalization(.none)
                      .multilineTextAlignment(.center)
                      .font(.title)
                      .border(Color.gray, width: 1)
                      .padding()
                    
                    
                    Button("SIGN UP") {
                      guard let url = URL(string: Constants.apiGatewayUrl + "/user") else { return }

                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                        let payload: [String: Any] = [
                            "username": username,
                            "password": password
                        ]
                        
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
                            request.httpBody = jsonData
                        } catch {
                            print("Error creating JSON data: \(error)")
                            return
                        }

                        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                            if let error = error {
                                print("Error: \(error)")
                                return
                            }
                            
                            if let data = data {
                                let response = String(data: data, encoding: .utf8)
                                print(response)

                                storedUsername = username
                                navigateToHome = true;
                            }
                        }
                        
                        task.resume()
                    } 
                        .font(.title2)
                        .buttonStyle(.borderedProminent)
                        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                        .frame(width: 250, height: 50)
                    
                    .fullScreenCover(isPresented: $navigateToHome) {
                        Home()
                    }
                }
            }
        }
    }
    
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        Signup()
    }
}


