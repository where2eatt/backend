//
//  Calendar.swift
//  where2eat
//
//  Created by stlp on 2/11/24.
//

import SwiftUI
import UIKit

class ViewController: UIViewController
{
    
}

import SwiftUI
import EventKit

struct Calendar: View {
    @State private var isPreferencesViewPresented = false

    var body: some View {
        ZStack {
            Color(red: 1, green: 1, blue: 0.9254901960784314)
                . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack (alignment: .center) {
                
                
                Text("MY CALENDAR AVAILABILITY")
                    .font(.title)
                    .font(.custom("Roboto", size: 26))
                    .fontWeight(.bold)
                    .padding(40)
                
                Image("calendar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
//                    .padding()
                
                Text("January 8th")
                    .font(.title)
                    .font(.custom("Roboto", size: 10))
                    .fontWeight(.semibold)
                    .padding(10.0)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Text("FROM")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { })
                }
                
                HStack {
                    Text("TO")
                        .font(.title)
                        .font(.custom("Roboto", size: 10))
                        .fontWeight(.semibold)
                        .padding(20.0)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { })
                }
               
                Spacer()
                
                Button("NEXT") {
                    isPreferencesViewPresented = true
                }
                    .font(.title2)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
                .sheet(isPresented: $isPreferencesViewPresented) {
                    Preferences()
                }
            }
        }
    }
    
}

struct Calendar_Previews: PreviewProvider {
    static var previews: some View {
        Calendar()
    }
}
