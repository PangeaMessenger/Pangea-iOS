//
//  MessageView.swift
//  Pangea
//
//  Created by Mattso on 12/07/2021.
//

import SwiftUI
import Firebase

enum MessagePosition {
    case left
    case right
}

struct MessageView: View {
    @ObservedObject var manager: MessageManager
    var otherMgr: AddContactManager
    @Binding var isShowing: Bool
    
    @State var msgText = ""
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    ScrollView(scrollToEnd: true) {
                        LazyVStack {
                            ForEach(0..<manager.messageArray.count, id:\.self) { index in
                                MessageBubble(position: manager.positionArray[index], color: manager.positionArray[index] == MessagePosition.right ?.black : .white, fColor: manager.positionArray[index] == MessagePosition.right ?.white : .black) {
                                    VStack(alignment: manager.positionArray[index] == MessagePosition.right ?.trailing : .leading) {
                                        Text(manager.messageArray[index])
                                        Text(manager.timeStampArray[index])
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top)
                    
                    HStack {
                        ZStack {
                            TextField("Message \(otherMgr.usrName ?? "")...", text: $msgText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 300, height: 50)
                                .overlay (
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 6)
                                )
                        }
                        .frame(height: 45)
                        
                        Button {
                            if msgText != "" {
                                manager.position = MessagePosition.right
                                manager.positionArray.append(manager.position)
                                manager.messageArray.append(msgText)
                                sendMessage(id: msgIDGen(length: 12), text: msgText, timeSent: Time().timeValue) {
                                    print("sent message")
                                }
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .padding(10)
                    }
                }
                .padding()
            }
            .navigationTitle("\(otherMgr.usrName ?? "An Error Occured")")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Done")
                }
            })
        }.onAppear(perform: getMessages)
    }
    
    func getMessages() {
        let msgReciever = Auth.auth().currentUser
        
        Database.database().reference().child("messages").child(msgReciever?.uid ?? "").child(otherMgr.usrId).observeSingleEvent(of: .value) { (snap) in
            
            if (snap.value is NSNull) {
                print("No messages found")
            } else {
                for messages in (snap.children) {
                    let rMsg = messages as! DataSnapshot
                    let dict = rMsg.value as! [String:String?]
                    
                    let msgText = dict["text"] as? String
                    let timeSent = dict["timeSent"] as? String
                    
                    print("\(msgText)")
                    
                    manager.messageArray.append(msgText ?? "")
                    manager.timeStampArray.append(timeSent ?? "")
                    manager.position = MessagePosition.left
                }
            }
        }
    }
    
    func msgIDGen(length: Int) -> String {
        let letters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    func sendMessage(id: String, text: String, timeSent: String, completion: @escaping () -> Void) {
        let msgSender = Auth.auth().currentUser
        Database.database().reference().child("messages").child(otherMgr.usrId).child(msgSender?.uid ?? "").child(id).setValue(["text" : text, "timeSent" : timeSent])
        
        Database.database().reference().child("messages").child(msgSender?.uid ?? "").child(otherMgr.usrId).child(id).setValue(["text" : text, "timeSent" : timeSent])
        
        self.msgText = ""
    }
}

struct MessageBubble<Content>: View where Content: View {
    @ObservedObject var manager = MessageManager()
    
    let position: MessagePosition
    let color : Color
    let fColor : Color
    let content: () -> Content
    init(position: MessagePosition, color: Color, fColor: Color, @ViewBuilder content: @escaping () -> Content) {
        self.position = position
        self.color = color
        self.fColor = fColor
        self.content = content
    }
    
    var body: some View {
        
        HStack(spacing: 0) {
                content()
                    .padding(15)
                    .foregroundColor(fColor)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            
        }
        .padding(position == .left ? .leading : .trailing , 15)
        .padding(position == .right ? .leading : .trailing , 60)
        .frame(width: UIScreen.main.bounds.width, alignment: position == .left ? .leading : .trailing)
    }
}

struct Time: View {
    let date: Date
    let dateFormatter: DateFormatter
    
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = .short
    }
    
    var timeValue: String {
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        Text(timeValue)
            .foregroundColor(Color(.systemGray3))
    }
}
