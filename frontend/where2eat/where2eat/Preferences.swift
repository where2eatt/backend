//
//  Preferences.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//
import SwiftUI
import UIKit

struct Preferences: View {
    @State private var cuisine = ""
    @State private var diet = ""
    @State private var price = ""
    @State private var location = ""
    @State private var accessibility = ""
    @State var choiceMade = "Select Cuisine"
    

    
    var items: [String] = [
        "bakery",
        "bar",
        "barbecue_restaurant",
        "brazilian_restaurant",
        "breakfast_restaurant",
        "brunch_restaurant",
        "cafe",
        "chinese_restaurant",
        "coffee_shop",
        "fast_food_restaurant",
        "french_restaurant",
        "greek_restaurant",
        "hamburger_restaurant",
        "ice_cream_shop",
        "indian_restaurant",
        "indonesian_restaurant",
        "italian_restaurant",
        "japanese_restaurant",
        "korean_restaurant",
        "lebanese_restaurant",
        "meal_delivery",
        "meal_takeaway",
        "mediterranean_restaurant",
        "mexican_restaurant",
        "middle_eastern_restaurant",
        "pizza_restaurant",
        "ramen_restaurant",
        "sandwich_shop",
        "seafood_restaurant",
        "spanish_restaurant",
        "steak_house",
        "sushi_restaurant",
        "thai_restaurant",
        "turkish_restaurant",
        "vietnamese_restaurant"
    ]
    
    @State var selectedButton = Set<String>()
    
    @State private var selectedOption = 0
    let dietoptions = ["None", "Vegetarian", "Vegan"]
    
    @State private var selectedPrice = 0
    let pricerange = ["$10", "$20", "$30", "$40", "$50", "$60"]
    
    @State private var selectedPriceTwo = 0
    let pricerangetwo = ["$10", "$20", "$30", "$40", "$50", "$60"]
    
    @State private var selectedDistance = 0
    let distancerange = ["15 min", " 30 min", "1 hour"]
    
    @State private var isPlacesViewPresented = false
    
    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .center, spacing: 20.0) {
                
                Text("MY PREFERENCES")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                HStack {
                    Text("CUISINE")
                        .font(.subheadline)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)

                    Menu {
                                ForEach(items, id: \.self) { item in
                                    Button(action: {
                                        self.choiceMade = item
                                    }) {
                                        Text(item.replacingOccurrences(of: "_", with: " ").capitalized)
                                    }
                                }
                            } label: {
                                Label(
                                    title: { Text("\(choiceMade ?? "Select an item")") },
                                    icon: { Image(systemName: "plus") }
                                )
                            }
                    }
                    
                    
                    HStack {
                        Text("DIETARY")
                            .font(.subheadline)
                            .font(.custom("Roboto", size: 10))
                            .fontWeight(.semibold)
                            .padding(20.0)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack {
                            Picker("Options", selection: $selectedOption) {
                                ForEach(0..<dietoptions.count) { index in
                                    Text(dietoptions[index]).tag(dietoptions[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .padding()
                    }
                    
                    
                    HStack {
                        Text("PRICE RANGE")
                            .font(.subheadline)
                            .font(.custom("Roboto", size: 10))
                            .fontWeight(.semibold)
                            .padding(20.0)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack {
                            HStack {
                                Picker("Options", selection: $selectedPrice) {
                                    ForEach(0..<pricerange.count) { index in
                                        Text(pricerange[index]).tag(pricerange[index])
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                
                                Text("TO")
                                    .font(.subheadline)
                                    .font(.custom("Roboto", size: 10))
                                    .fontWeight(.semibold)
                                    .padding(10.0)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                Picker("Options", selection: $selectedPriceTwo) {
                                    ForEach(0..<pricerangetwo.count) { index in
                                        Text(pricerangetwo[index]).tag(pricerangetwo[index])
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                
                            }
                        }
                        .padding()
                        
                    }
                    
                    HStack {
                        Text("DISTANCE")
                            .font(.subheadline)
                            .font(.custom("Roboto", size: 10))
                            .fontWeight(.semibold)
                            .padding(20.0)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        VStack {
                            Picker("DistanceOptions", selection: $selectedDistance) {
                                ForEach(0..<distancerange.count) { index in
                                    Text(distancerange[index]).tag(distancerange[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                        }
                        .padding()
                        
                    }
                    
                    
                    Button("NEXT") {
                        guard let url = URL(string: "https://077vfaggvg.execute-api.us-west-2.amazonaws.com/prod/session") else { return }
                        
                        
                        var request = URLRequest(url: url)
                        request.httpMethod = "PATCH"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        
                        let payload: [String: Any] = [
                            "username": "user1",
                            "sessionId": "1709079639620_9ac7b523-6185-4a9c-aa6d-7e19f490087e",
                            "preferences": [
                                "cuisine": choiceMade
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
                        
                        isPlacesViewPresented = true
                    }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                    
                    .sheet(isPresented: $isPlacesViewPresented) {
                        Places()
                    }
                }
            }
        }
    }
    
    struct Preferences_Previews: PreviewProvider {
        static var previews: some View {
            Preferences()
        }
    }


