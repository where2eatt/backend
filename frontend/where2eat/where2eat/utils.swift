//
//  utils.swift
//  where2eat
//
//  Created by Adrien Delepine on 3/6/24.
//

import Foundation

func updateSession(sessionId: String, username: String, cuisine: String, dietaryOption: String) {
  guard let url = URL(string: Constants.apiGatewayUrl + "/session") else { return }
  
  var request = URLRequest(url: url)
  request.httpMethod = "PATCH"
  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
  let payload: [String: Any] = [
    "username": username,
    "sessionId": sessionId,
    "preferences": [
      "cuisine": cuisine,
      "dietaryRestrictions": dietaryOption
    ]
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
      
      // Handle response data
    }
  }
  task.resume()
}

func updateMessage(sessionId: String, username: String, message: String) {
  guard let url = URL(string: Constants.apiGatewayUrl + "/sessionMessage") else { return }
  
  var request = URLRequest(url: url)
  request.httpMethod = "PATCH"
  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
  let payload: [String: Any] = [
    "sessionId": sessionId,
    "username": username,
    "message": message
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
      
      // Handle response data
    }
  }
  task.resume()
}

func updateMessage(sessionId: String, currentChat: Array) {
  guard let url = URL(string: Constants.apiGatewayUrl + "/sessionMessage") else { return }
  
  var request = URLRequest(url: url)
  request.httpMethod = "GET"
  request.setValue("application/json", forHTTPHeaderField: "Content-Type")
  
  let payload: [String: Any] = [
    "sessionId": sessionId
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
    print(data)
    if let data = data {
      let response = String(data: data, encoding: .utf8)
      
      // Handle response data
    }
  }
  task.resume()
}
