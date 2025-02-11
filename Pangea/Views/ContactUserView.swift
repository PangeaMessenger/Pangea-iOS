//
//  ContactUserView.swift
//  Pangea
//
//  Created by Mattso on 13/07/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct ContactUserView: View {
    @Binding var isShowing: Bool
    
    let addContactView = AddContactView()
    @ObservedObject var mgr: AddContactManager
    
    var body: some View {
        NavigationView {
            VStack {
                WebImage(url: mgr.usrProfileImg)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding(8)
                Text("\(mgr.usrName ?? "")")
                    .bold()
                    .font(.system(size: 30))
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(.systemGray3))
                        .frame(width: 100, height: 50)
                    
                    HStack {
                        Button {
                            print("message")
                        } label: {
                            Image(systemName: "message.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                    
                        Button {
                            print("block")
                        } label: {
                            Image(systemName: "nosign")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                        }
                    
                    }
                    
                }
                
                Spacer()
                
                HStack {
                    Button {
                        mgr.addAsContact()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.blue)
                                .frame(height: 100)
                        
                            Text("Add Contact")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
