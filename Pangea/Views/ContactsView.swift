//
//  ContactsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI

struct ContactsView: View {
    @Binding var isShowing: Bool
    @State var showingContactUserView = false
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("A")) {
                    Text("Alan")
                }
                
                Section(header: Text("J")) {
                    Button("Jeff") {
                        showingContactUserView.toggle()
                    }.sheet(isPresented: $showingContactUserView) {
                        ContactUserView(isShowing: $showingContactUserView)
                    }
                    Text("James")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Contacts")
            .toolbar(content: {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("add")
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Spacer()
                
                    Button {
                        isShowing.toggle()
                    } label: {
                        Text("Done")
                    }
                }
            })
        }
    }
}
