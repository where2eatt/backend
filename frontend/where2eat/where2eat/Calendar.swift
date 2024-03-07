import SwiftUI
import UIKit

struct Calendar: View {
  @State private var isPreferencesViewPresented = false
  @AppStorage("sessionId") var storedSessionId: String = ""
  @State private var isSessionIdCopied = false
  
  var body: some View {
    ZStack {
    //   VStack {
        Color(red: 1, green: 1, blue: 0.9254901960784314)
          . edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        
        VStack (alignment: .center) {
          Text("MY AVAILABILITY")
            .font(.title)
            .font(.custom("Roboto", size: 26))
            .fontWeight(.bold)
            .padding(40)
          
          HStack {
            Text("FROM")
              .font(.title)
              .font(.custom("Roboto", size: 10))
              .fontWeight(.semibold)
              .padding(20.0)
              .multilineTextAlignment(.center)
              .fixedSize(horizontal: false, vertical: true)
            
            DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { })
              .padding(20.0)
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
                        .padding(20.0)
            }
          Button("NEXT") {
              isPreferencesViewPresented = true
          }
            .font(.title2)
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                
            .sheet(isPresented: $isPreferencesViewPresented) {
                Preferences()
            }
          Button(action: {
            UIPasteboard.general.string = storedSessionId
            isSessionIdCopied = true
          }) {
            Text("COPY SESSION ID")
            Image(systemName: "doc.on.doc")
              .font(.system(size: 12))
              .foregroundColor(.white)
          }
          .font(.title2)
          .buttonStyle(.borderedProminent)
          .tint(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
          .alert(isPresented: $isSessionIdCopied) {
            Alert(title: Text("Session ID Copied"), message: nil, dismissButton: .default(Text("OK")))
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
