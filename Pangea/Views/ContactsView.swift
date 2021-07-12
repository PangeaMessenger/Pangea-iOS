//
//  ContactsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI

struct ContactsView: View {
    @Binding var isShowing: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("A")) {
                    Text("Alan")
                }
                
                Section(header: Text("J")) {
                    Text("Jeff")
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
