//
//  WelcomeView.swift
//  Pangea
//
//  Created by Mattso on 19/08/2021.
//

import SwiftUI
import Firebase

struct WelcomeView: View {
    
    @Binding var isShowing: Bool
    
    @State var showingSignUp = false
    @State var showingLogin = false
    @State private var password: String = ""
    @State var passwordConfirm: String = ""
    @State private var email: String = ""
    
    @State private var authSuccess: Bool = false
    @State var buttonPushed: Bool = false
    @State var passwordsNoMatch: Bool = true
    @State var int: Int = 0
    
    var body: some View {
        NavigationView {
        VStack {
            
            if int == 0 {
                Text("Welcome to Pangea")
                    .bold()
                    .font(.system(size: 50))
                
                
                Button  {
                    int = 1
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                        
                        Text("Sign Up")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    .frame(height: 150)
                }
                
                Button {
                    int = 2
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                        
                        Text("Login")
                            .font(.system(size: 25))
                            .foregroundColor(.black)
                    }
                    .frame(height: 150)
                }
            } else if int == 1 {
                Button {
                    int = 0
                } label: {
                    Text("Cancel")
                }
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
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.white)
                        
                        Text("Sign Up")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    }
                    .frame(height: 100)
                    .onTapGesture {
                        if password == passwordConfirm {
                            signUp()
                            buttonPushed = true
                            passwordsNoMatch = false
                        } else {
                            buttonPushed = true
                            authSuccess = false
                            passwordsNoMatch = true
                        }
                    }
                }
            } else if int == 2 {
                Button {
                    int = 0
                } label: {
                    Text("Cancel")
                }
                Text("Login")
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
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(.white)
                    
                    Text("Login")
                        .foregroundColor(.black)
                        .font(.system(size: 25))
                }
                .frame(height: 100)
                .onTapGesture {
                    buttonPushed = true
                    login()
                }
            }
        }
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
