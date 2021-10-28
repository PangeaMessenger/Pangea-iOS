//
//  UserInfoView.swift
//  Pangea
//
//  Created by Mattso on 12/10/2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct UserInfoView: View {
    @Binding var isShowing: Bool
    @State var isShowingMsgView: Bool = false
    
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
                Text(mgr.usrId)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(.systemGray3))
                        .frame(width: 100, height: 50)
                    
                    HStack {
                        Button {
                            mgr.findUser(id: mgr.usrId) {
                                isShowingMsgView.toggle()
                            }
                        } label: {
                            Image(systemName: "message.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }.sheet(isPresented: $isShowingMsgView) {
                            MessageView(otherMgr: mgr, isShowing: $isShowingMsgView)
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
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

