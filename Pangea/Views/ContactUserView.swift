//
//  ContactUserView.swift
//  Pangea
//
//  Created by Mattso on 13/07/2021.
//

import Foundation
import SwiftUI

struct ContactUserView: View {
    @Binding var isShowing: Bool
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: UIImage(named: "jeff") ?? UIImage())
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .padding(8)
                Text("Jeff")
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
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
