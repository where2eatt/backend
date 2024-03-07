import SwiftUI
import UIKit

struct Places: View {
    @State private var displayNames: [String] = []
    @State private var isLoading = true // Added isLoading state
    @AppStorage("sessionId") var storedSessionId: String?
    
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
                
                if isLoading { // Show loading icon while isLoading is true
                    ProgressView()
                } else {
                    List(displayNames, id: \.self) { displayName in
                        Text(displayName)
                    }
                }
            }
        }
        .onAppear {
            fetchData()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
                            isLoading = false // Set isLoading to false after data is fetched
                        }
                    }
                }
            }.resume()
        }
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
