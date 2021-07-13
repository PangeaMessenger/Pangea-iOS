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
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login")
                    .bold()
                    .font(.system(size: 60))
                    .padding(10)
                VStack(alignment: .center) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                    TextField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 300)
                }
                Spacer()
                
                Button {
                    print("create account")
                } label: {
                    Text("I don't have an account")
                }
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
}
