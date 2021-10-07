//
//  SettingsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct SettingsView: View {
    @Binding var isShowing: Bool
    @State var isLoggedOut = false
    @State var isShowingEditView: Bool = false
    
    let userEmail: String = (Auth.auth().currentUser?.displayName)!
    let profileImg: URL = (Auth.auth().currentUser?.photoURL) as! URL
    let userID: String = (Auth.auth().currentUser?.uid)!
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
                        WebImage(url: profileImg)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding(8)

                        Text(userEmail)
                            .font(.system(size: 30))
                            .bold()
                        
                        Text(userID)
                            .font(.system(size: 15))
                    }
                }
            
                HStack(spacing: 10) {
                    Spacer()
                    VStack(spacing: 2) {
                        Button {
                            isShowingEditView.toggle()
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
                        }.sheet(isPresented: $isShowingEditView) {
                            EditUserInfo(isShowing: $isShowingEditView)
                        }
                        
                        Button {
                            print("logout")
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
                        }.fullScreenCover(isPresented: $isLoggedOut) {
                            WelcomeView(isShowing: $isLoggedOut)
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
