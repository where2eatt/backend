import SwiftUI
import UIKit

struct Places: View {
    @State private var displayNames: [String] = []
    @AppStorage("sessionId") var storedSessionId: String?
    @State private var navigateToChatroom = false
    @State private var isGoingToSessions = false


    
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                Text("LOCATION RECOMMENDATIONS")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                List(displayNames, id: \.self) { displayName in
                    Text(displayName)
                }
            }
            
        }
        .onAppear {
            fetchData()
        }
        Button("GO TO GROUP CHAT") {
            navigateToChatroom = true
        }
        .font(.title2)
        .buttonStyle(.borderedProminent)
        .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
        
        .sheet(isPresented: $navigateToChatroom) {
            Chatroom()
        }
        
        Button("HOME") {
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
    
    func fetchData() {
        guard var urlComponents = URLComponents(string: Constants.apiGatewayUrl + "/recommendation") else {
            print("Invalid URL")
            return
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "sessionId", value: storedSessionId ?? "")
        ]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response: \(jsonString)")
                    if let placesResponse = try? JSONDecoder().decode(PlacesResponse.self, from: data) {
                        displayNames = placesResponse.places.map { $0.displayName.text }
                    }
                }
            }
        }.resume()
    }
}

struct PlacesResponse: Codable {
    let places: [Place]
}

struct Place: Codable {
    let displayName: DisplayName
}

struct DisplayName: Codable {
    let text: String
    let languageCode: String
}
