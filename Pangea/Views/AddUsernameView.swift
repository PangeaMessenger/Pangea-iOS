//
//  AddUsernameView.swift
//  Pangea
//
//  Created by Mattso on 28/09/2021.
//

import SwiftUI
import Firebase

struct AddUsernameView: View {
    @State var hasSetInfo: Bool = false
    @State var username: String = ""
    @State var photoUrl: String = ""
    
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up")
                    .bold()
                    .font(.system(size: 45))
                
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextField("Photo URL", text: $photoUrl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                
                Button {
                    addStuff() {
                        hasSetInfo.toggle()
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue)
                    
                        Text("Done")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }.fullScreenCover(isPresented: $hasSetInfo) {
                    MessageListView()
                }
            }
        }
    }
    
    func addStuff(completion: @escaping () -> Void) {
        if let pangeaUser = Auth.auth().currentUser {
            changeRequest?.displayName = username
            changeRequest?.photoURL = URL(string: photoUrl)
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("an error happened: \(error)")
                    return completion()
                } else {
                    let userData = ["email" : pangeaUser.email!, "name" : self.username, "profileImg" : self.photoUrl]
                    Database.database().reference().child("users").child(pangeaUser.uid).updateChildValues(userData)
                    print("successfully added display name")
                    return completion()
                }
            }
        }
    }
}
