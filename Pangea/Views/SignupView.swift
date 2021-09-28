//
//  SignupView.swift
//  Pangea
//
//  Created by Mattso on 19/08/2021.
//

import SwiftUI
import Firebase

struct SignupView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var password: String = ""
    @State var passwordConfirm: String = ""
    @State private var email: String = ""
    
    @State private var authSuccess: Bool = false
    @State var buttonPushed: Bool = false
    @State var passwordsNoMatch: Bool = true
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Sign Up")
                    .bold()
                    .font(.system(size: 60))
                    .padding(10)
                
                VStack(alignment: .center) {
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    SecureField("Confirm Password", text: $passwordConfirm)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    
                    if buttonPushed == true {
                        if authSuccess == false {
                            Text("An error occured")
                        } else {
                            Text("Creating account...")
                        }
                        
                        if passwordsNoMatch == true {
                            Text("Your passwords do not match. Please try again.")
                        }
                    } else {
                        
                    }
                    
                    Spacer()
                    
                        Button {
                            if password == passwordConfirm {
                                signUp()
                                buttonPushed = true
                                passwordsNoMatch = false
                            } else {
                                buttonPushed = true
                                authSuccess = false
                                passwordsNoMatch = true
                            }
                        } label: {
                            ZStack {
                                if(colorScheme == .dark) {
                                    RoundedRectangle(cornerRadius: 25)
                                        .foregroundColor(.white)
                                
                                    Text("Sign Up")
                                        .foregroundColor(.black)
                                        .font(.system(size: 25))
                                } else {
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.black, lineWidth: 5)
                                        .foregroundColor(.white)
                                    
                                    Text("Sign Up")
                                        .foregroundColor(.black)
                                        .font(.system(size: 25))
                                }
                            }.frame(width: 350, height: 100)
                        }.fullScreenCover(isPresented: $authSuccess) {
                            MessageListView()
                        }
                }
            }
            .navigationTitle("Sign Up")
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
    
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                authSuccess = false
                print("Uh oh! \(error?.localizedDescription)")
            } else {
                authSuccess = true
                print("Sign up success!")
            }
        }
    }
}