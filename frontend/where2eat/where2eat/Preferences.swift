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
    
    @State private var selectedOption = 0
    let dietoptions = ["Vegetarian", "Vegan", "Halal"]
    
    @State private var selectedPrice = 0
    let pricerange = ["$10", "$20", "$30", "$40", "$50", "$60"]
    
    @State private var selectedPriceTwo = 0
    let pricerangetwo = ["$10", "$20", "$30", "$40", "$50", "$60"]
    
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
                    Text("CUISINE & PALETTE ADVENTURENESS")
                        .font(.subheadline)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Search for cuisine", text: $cuisine)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
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
                        //                           Text("Select a Dietary/Allergen")
                        
                        Picker("Options", selection: $selectedOption) {
                            ForEach(0..<dietoptions.count) { index in
                                Text(dietoptions[index]).tag(dietoptions[index])
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        Text("Selected Option: \(dietoptions[selectedOption])")
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
                    Text("LOCATION")
                        .font(.subheadline)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Search for cuisine", text: $location)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                HStack {
                    Text("ACCESSIBILITY")
                        .font(.subheadline)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    TextField("Search for Accessibility", text: $accessibility)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                
                Button("NEXT") {
                    
                }
                
                .font(.title2)
                .buttonStyle(.borderedProminent)
                .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
                //        Spacer()
                
                Rectangle()
                    .fill(Color(red: 0.9607843137254902, green: 0.9607843137254902, blue: 0.9607843137254902))
                    .frame(height: 100)
                
                    .overlay(
                        HStack {
                            Image("home")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                                .padding()
                            
                            Image("plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                                .padding()
                            
                            Image("chat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 90)
                                .padding()
                        }
                        
                    )
                
            }
        }
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
