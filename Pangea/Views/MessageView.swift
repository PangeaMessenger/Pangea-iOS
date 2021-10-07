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
    let db = Firestore.firestore()
    
    @ObservedObject var manager = MessageManager()
    @Binding var isShowing: Bool
    
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
                                        Time()
                                    }
                                }
                            }
                        }
                    }
                    .padding(.top)
                    
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 6)
                            TextEditor(text: $manager.text)
                        }
                        .frame(height: 45)
                        
                        Button {
                            if manager.text != "" {
                                manager.position = manager.position == MessagePosition.right ? MessagePosition.left : MessagePosition.right
                                manager.positionArray.append(manager.position)
                                manager.messageArray.append(manager.text)
                                manager.text = ""
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }
                        .padding(10)
                    }
                }
                .padding()
            }
            .navigationTitle("John Smith")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Done")
                }
            }
            )
        }
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
