//
//  MessageListView.swift
//  Pangea
//
//  Created by Mattso on 03/07/2021.
//

import Foundation
import SwiftUI

struct MessageListView: View {
    @State private var showingMessageView = false
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Divider()
                    HStack {
                        Image(uiImage: UIImage(named: "jeff") ?? UIImage())
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 75, height: 75)
                            .padding(10)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Jeff")
                                .bold()
                            Text("My name is Jeff.")
                                .foregroundColor(Color(.systemGray))
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("4:20am")
                                .foregroundColor(Color(.systemGray3))
                                .padding(5)
                            Text(">")
                                .foregroundColor(Color(.systemGray3))
                                .padding(10)
                        }
                    }
                    Divider()
                }
                .onTapGesture {
                    showingMessageView.toggle()
                }.sheet(isPresented: $showingMessageView) {
                    MessageView(isShowing: $showingMessageView)
                }
                
                VStack {
                    HStack {
                        Image(uiImage: UIImage(named: "pwnage") ?? UIImage())
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 75, height: 75)
                            .padding(10)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Rpwnage")
                                .bold()
                            Text("Manticore s0n")
                                .foregroundColor(Color(.systemGray))
                        }
                        Spacer()
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("1:37pm")
                                .foregroundColor(Color(.systemGray3))
                                .padding(5)
                            Text(">")
                                .foregroundColor(Color(.systemGray3))
                                .padding(10)
                        }
                    }
                    Divider()
                }
                Spacer()
                
                ZStack(alignment: .bottomTrailing) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(maxWidth: .infinity)
                    FloatingButton()
                        .padding()
                }

                
            }

            .navigationBarTitle(Text("Messages"))
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("contacts list tapped")
                    } label: {
                        Image(systemName: "rectangle.stack.person.crop.fill")
                    }
                    
                    Spacer()
                
                    Button {
                        print("settings")
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            })
        }
    }
}

struct FloatingButton: View {
    var body: some View {
        Menu {
            Button {
                print("add contact")
                } label: {
                    Label("Add a Contact", systemImage: "person.fill")
                }
            
            Button {
                print("start chat")
                } label: {
                    Label("Start a Chat", systemImage: "message.fill")
                }
            
            Button {
                print("make group chat")
                } label: {
                    Label("Make a Group Chat", systemImage: "person.3.fill")
                }
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color(.white))
            }
    }
}
