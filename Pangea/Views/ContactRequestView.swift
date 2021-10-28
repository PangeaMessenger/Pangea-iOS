//
//  ContactRequestView.swift
//  Pangea
//
//  Created by Mattso on 10/10/2021.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContactRequestView: View {
    @Binding var isShowing: Bool
    
    let addContactView = AddContactView()
    @ObservedObject var mgr: AddContactManager
    let reqMgr = ContactRequestManager()
    
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
                
                VStack {
                    Button {
                        reqMgr.acceptRequest(id: mgr.usrId ?? "") {
                            print("Accepted Request")
                        }
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.blue)
                                .frame(height: 100)
                        
                            Text("Accept Request")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        print("lmao")
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(.red)
                                .frame(height: 100)
                        
                            Text("Decline Request")
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
