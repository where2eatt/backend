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
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                    
                    SecureField("Create Password", text: $password)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                    
                    SecureField("Re-enter Password", text: $reenter)
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .border(Color.gray, width: 1)
                        .padding()
                    
                    
                    Button("SIGN UP") {
                        guard let url = URL(string: "https://077vfaggvg.execute-api.us-west-2.amazonaws.com/prod/user") else { return }

                        var request = URLRequest(url: url)
                        request.httpMethod = "POST"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                        let body = ["username": username]
                        let jsonData = try? JSONSerialization.data(withJSONObject: body)
                        request.httpBody = jsonData
                            URLSession.shared.dataTask(with: url) { (data, response, error) in
                                if let error = error {
                                    print("Error: \(error.localizedDescription)")
                                    return
                                }
                                
                                if let httpResponse = response as? HTTPURLResponse {
                                    if httpResponse.statusCode == 404 {
                                        showErrorAlert = true
                                    } else {
                                        navigateToHome = true
                                    }
                                }
                            }.resume()
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


