//
//  SettingsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var isShowing: Bool
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .center, spacing: 2) {
                    Image(uiImage: UIImage(named: "pwnage") ?? UIImage())
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                        .padding(8)
            
                    Text("RPwnage")
                        .font(.system(size: 30))
                        .bold()
                    }
            
                VStack(spacing: 2) {
                    Button {
                        print("edit info")
                    } label: {
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.white)
                            Text("Edit my Information")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color(.systemGray5))
                    }
                    
                    Button {
                        print("notifiction settings")
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.bubble.fill")
                                .foregroundColor(.white)
                            Text("Notifications")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color(.systemGray5))
                    }
                    
                    Button {
                        print("privacy settings")
                    } label: {
                        HStack {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(.white)
                            Text("Privacy")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color(.systemGray5))
                    }
                    
                    Button {
                        print("reset app")
                    } label: {
                        HStack {
                            Image(systemName: "trash.fill")
                                .foregroundColor(.white)
                            Text("Reset App")
                                .foregroundColor(.white)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .background(Color.red)
                    }
                }
                Spacer()
            }
            
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                Button {
                    isShowing.toggle()
                } label: {
                    Text("Done")
                }
            })
        }
    }
}
