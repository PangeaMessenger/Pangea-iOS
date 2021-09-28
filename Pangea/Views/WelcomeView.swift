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
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
        VStack {
                Text("Welcome to Pangea")
                    .bold()
                    .font(.system(size: 50))
                
                
                Button  {
                    showingSignUp.toggle()
                } label: {
                    ZStack {
                        if(colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.white)
                            
                            Text("Sign Up")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 5)
                                .foregroundColor(.white)
                                
                            
                            Text("Sign Up")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 350,height: 150)
                }.fullScreenCover(isPresented: $showingSignUp) {
                    SignupView()
                }
                
                Button {
                    showingLogin.toggle()
                } label: {
                    
                    ZStack {
                        if(colorScheme == .dark) {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.white)
                            
                            Text("Login")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 5)
                            
                            Text("Login")
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: 350,height: 150)
                }.fullScreenCover(isPresented: $showingLogin) {
                    LoginView()
                }
            }
        }
    }
    
}
