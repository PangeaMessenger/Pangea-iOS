//
//  LoginView.swift
//  Pangea
//
//  Created by Mattso on 19/08/2021.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var password: String = ""
    @State private var email: String = ""
    
    @State var buttonPushed: Bool = false
    @State private var authSuccess: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .bold()
                    .font(.system(size: 60))
                    .padding(10)
                VStack(alignment: .center) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    
                    if buttonPushed == true {
                        if authSuccess == false {
                            Text("An error occured. Please check that the information is entered correctly!")
                                .foregroundColor(.red)
                        } else {
                            Text("Successfully logged in as \(email)")
                                .foregroundColor(.green)
                        }
                    }
                    
                }
                Spacer()
                
                    Button {
                        buttonPushed = true
                        login()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.white)
                            
                            Text("Login")
                                .foregroundColor(.black)
                                .font(.system(size: 25))
                        }.frame(height: 100)
                    }.fullScreenCover(isPresented: $authSuccess) {
                        MessageListView()
                    }
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("< Back")
                    }
                }
            })
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                authSuccess = false
                print("Uh oh! \(error?.localizedDescription)")
            } else {
                authSuccess = true
                print("Logged in successfully!")
            }
        }
    }
}
