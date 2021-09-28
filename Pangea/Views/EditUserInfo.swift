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
                
                TextField("Profile Image URL", text: $photoURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                    .autocapitalization(.none)
                
                Button {
                    changeRequest?.displayName = username
                    changeRequest?.photoURL = NSURL(string: photoURL) as URL?
                    changeRequest?.commitChanges { error in
                        if let error = error {
                            print("an error happened: \(error)")
                        } else {
                            print("successfully changed user info")
                            isShowing.toggle()
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue)
                        
                        Text("Change")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}
