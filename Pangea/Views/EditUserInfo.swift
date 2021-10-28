//
//  EditUserInfo.swift
//  Pangea
//
//  Created by Mattso on 28/09/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct EditUserInfo: View {
    @Binding var isShowing: Bool
    @State var isShowingHome: Bool = false
    @State var userEmail: String = (Auth.auth().currentUser?.email)!
    @State var username: String = ""
    @State var photoURL: String = ""
    
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Edit Your Info")
                    .bold()
                    .font(.system(size: 42))
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("Profile Image URL", text: $photoURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button {
                    updateStuff {
                        isShowing.toggle()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue)
                        
                        Text("Change")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }.frame(height: 100)
                }.fullScreenCover(isPresented: $isShowingHome) {
                    MessageListView()
                }
            }
        }
    }
    
    func updateStuff(completion: @escaping () -> Void) {
        if let pangeaUser = Auth.auth().currentUser {
            changeRequest?.displayName = username
            changeRequest?.photoURL = URL(string: photoURL)
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("an error happened: \(error)")
                    return completion()
                } else {
                    let userData = ["name" : self.username, "profileImg" : self.photoURL]
                    Database.database().reference().child("users").child(pangeaUser.uid).updateChildValues(userData)
                    print("successfully edited display name")
                    return completion()
                }
            }
        }
    }
}
