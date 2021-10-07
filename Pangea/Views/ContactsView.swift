//
//  ContactsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI

struct ContactsView: View {
    @Binding var isShowing: Bool
    @State var showingContactUserView: Bool = false
    @State var showingAddContactView: Bool = false
    
    let contactsMgr = ContactManager()
    
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
                        showingAddContactView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }.sheet(isPresented: $showingAddContactView) {
                        AddContactView()
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
    
    func handleReload(_ contacts: [ContactInfo]) {
        Contacts.list = contacts
        Contacts.list.sort { (contact1, contact2) -> Bool  in
            return contact1.name ?? "" < contact2.name ?? ""
        }
    }
    
    
}
