//
//  LoginView.swift
//  Pangea
//
//  Created by Mattso on 13/07/2021.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @Binding var isShowing: Bool
    @State private var showingSignupView = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var authenticationFailed: Bool = false
    
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
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    
                    if authenticationFailed {
                        Text("An error occured. Please check that the information is entered correctly!")
                    }
                }
                Spacer()
                Button {
                    print("create account")
                    showingSignupView.toggle()
                } label: {
                    Text("I don't have an account")
                }.sheet(isPresented: $showingSignupView, content: {
                    SignUpView(isShowing: $showingSignupView)
                })
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar (content: {
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Cancel")
                }
            })
        }
    }
}

struct user {
    static var isLoggedIn: Bool = false
    static var hasMessages: Bool = false
}
