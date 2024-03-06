import SwiftUI
import UIKit

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var isUser: Bool // Indicates if the message is sent by the user
}

struct Chatroom: View {
    @State private var messages: [Message] = []
    @State private var newMessageText = ""
    

    var body: some View {
        
        
        VStack {
            
            List(messages) { message in
                MessageView(message: message)
            }
            HStack {
                TextField("Enter your message", text: $newMessageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    sendMessage()
                }
            }.padding()
        }
    }

    func sendMessage() {
        if !newMessageText.isEmpty {
            let message = Message(text: newMessageText, isUser: true)
            messages.append(message)
            newMessageText = ""
        }
    }
}

struct MessageView: View {
    var message: Message

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color(red: 1, green: 1, blue: 0))
                    .cornerRadius(8)
            } else {
                Text(message.text)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(Color(red: 1, green: 1, blue: 0))
                    .cornerRadius(8)
                Spacer()
            }
        }
    }
}

struct Chatroom_Previews: PreviewProvider {
    static var previews: some View {
        Chatroom()
    }
}
