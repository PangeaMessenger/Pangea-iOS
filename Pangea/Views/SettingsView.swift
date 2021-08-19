//
//  SettingsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @Binding var isShowing: Bool
    @State var showingLoginView = false
    @State var isLoggedOut = false
    
    let userEmail: String = (Auth.auth().currentUser?.email)!
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 2) {
                    if Auth.auth().currentUser == nil {
                        Image(uiImage: UIImage(named: "notlogged") ?? UIImage())
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(8)
            
                        Text("Not Logged In")
                            .font(.system(size: 30))
                            .bold()
                    } else {
                        Image(uiImage: UIImage(named: "notlogged") ?? UIImage())
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(8)
            
                        Text(userEmail)
                            .font(.system(size: 30))
                            .bold()
                    }
                }
            
                HStack(spacing: 10) {
                    Spacer()
                    VStack(spacing: 2) {
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
                        
                        Button {
                            print("Logout")
                            logOut()
                        } label: {
                            HStack {
                                Text("Log Out")
                                    .foregroundColor(.white)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(.systemRed))
                        }
                    
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
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let logOutError as NSError {
            print("An error occured logging out: \(logOutError)")
            isLoggedOut = false
        }
        
        isLoggedOut = true
    }
}
