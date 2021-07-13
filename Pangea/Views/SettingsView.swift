//
//  SettingsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var isShowing: Bool
    @State var showingLoginView = false
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 2) {
                    Image(uiImage: UIImage(named: "notlogged") ?? UIImage())
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding(8)
            
                    Text("Not Logged In")
                        .font(.system(size: 30))
                        .bold()
                    }
            
                HStack(spacing: 10) {
                    Spacer()
                    VStack(spacing: 2) {
                    if user.isLoggedIn == false {
                        Button {
                            showingLoginView.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.plus")
                                    .foregroundColor(.white)
                                Text("Login")
                                    .foregroundColor(.white)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(.systemGray5))
                        }.sheet(isPresented: $showingLoginView) {
                            LoginView(isShowing: $showingLoginView)
                        }
                        
                        Button {
                            showingLoginView.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.fill.badge.checkmark")
                                    .foregroundColor(.white)
                                Text("Sign up")
                                    .foregroundColor(.white)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(.systemGray5))
                        }.sheet(isPresented: $showingLoginView) {
                            LoginView(isShowing: $showingLoginView)
                        }
                    } else {
                    
                        Button {
                            print("edit info")
                        } label: {
                            HStack {
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                Text("Edit my Information")
                                    .foregroundColor(.white)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(.systemGray5))
                        }
                    }
                    
                    if user.isLoggedIn == true {
                    Button {
                        print("notifiction settings")
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.bubble.fill")
                                .foregroundColor(.white)
                            Text("Notifications")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color(.systemGray5))
                    }
                    
                    Button {
                        print("privacy settings")
                    } label: {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(.white)
                            Text("Privacy")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color(.systemGray5))
                    }
                    }
                    Button {
                        print("reset app")
                    } label: {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                            Text("Reset App")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color.red)
                    }
                }
                    Spacer()
                }
                Spacer()
            }
            
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Done")
                }
            })
        }
    }
}
