//
//  SignUpView.swift
//  Pangea
//
//  Created by Mattso on 18/08/2021.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @Binding var isShowing: Bool
    @State private var password: String = ""
    @State var passwordConfirm: String = ""
    @State private var email: String = ""
    
    @State private var authenticationFailed: Bool = false
    
    @EnvironmentObject var session: SessionStore
    
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
                    
                    if authenticationFailed {
                        Text("An error occured")
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
                        
                    }
                }
                Spacer()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
