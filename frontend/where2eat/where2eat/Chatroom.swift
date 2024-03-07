import SwiftUI
import UIKit

struct Message: Identifiable {
    var id = UUID()
    var text: String
    var isUser: Bool
    var username: String
}

struct Chatroom: View {
    @State private var messages: [Message] = []
    @State private var newMessageText = ""
    @AppStorage("sessionId") var storedSessionId: String?
    @AppStorage("username") var storedUsername: String?
    
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
        .onAppear {
            getMessages(sessionId: storedSessionId ?? "", username: storedUsername ?? "") { messageList in
                messages = messageList
            }
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
              getMessages(sessionId: storedSessionId ?? "", username: storedUsername ?? "") { messageList in
                messages = messageList
            }
            }
        }
    }
    
    func sendMessage() {
        if !newMessageText.isEmpty {
            let message = Message(text: newMessageText, isUser: true, username: storedUsername ?? "")
            messages.append(message)
            postMessage(sessionId: storedSessionId ?? "", username: storedUsername ?? "", message: newMessageText)
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
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.41568627450980394, green: 0.6509803921568628, blue: 0.3803921568627451))
                    .cornerRadius(8)
            } else {
                Text(message.text)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(red: 0.34901960784313724, green: 0.49411764705882355, blue: 0.3215686274509804))
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
