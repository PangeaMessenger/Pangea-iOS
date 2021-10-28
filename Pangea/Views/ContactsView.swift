//
//  ContactsView.swift
//  Pangea
//
//  Created by Luca on 12.07.21.
//

import SwiftUI
import Firebase

struct ContactStuff {
    let name: String
    let id: String
}

struct ContactsView: View {
    @Binding var isShowing: Bool
    @State var showingContactUserView: Bool = false
    @State var showingAddContactView: Bool = false
    @State var showingUserInfoView: Bool = false
    
    let currentUser = Auth.auth().currentUser
    
    @ObservedObject var contactsMgr: ContactManager
    @ObservedObject var reqMgr: ContactRequestManager
    let addMgr = AddContactManager()
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Contact Requests")) {
                    Button {
                        reqMgr.loadRequests {
                            print("Loaded requests")
                        }
                        
                    } label: {
                        Text("Load Requests")
                    }
                    
                    Button {
                        showingContactUserView.toggle()
                        addMgr.findUser(id: reqMgr.contactReqId) {
                            print("Got ID")
                        }
                    } label: {
                        Text("\(reqMgr.contactReqName)")
                    }.sheet(isPresented: $showingContactUserView) {
                        ContactRequestView(isShowing: $showingContactUserView, mgr: addMgr)
                    }
                    
                }
                
                Section(header: Text("Contacts")) {
                    ForEach(0..<contactsMgr.contactNames.count, id: \.self) { contact in
                        Button {
                            print(contactsMgr.contactIds[contact])
                            addMgr.findUser(id: contactsMgr.contactIds[contact]) {
                                showingUserInfoView.toggle()
                            }
                        } label: {
                            Text("\(contactsMgr.contactNames[contact])")
                        }.sheet(isPresented: $showingUserInfoView) {
                            UserInfoView(isShowing: $showingUserInfoView, mgr: addMgr)
                        }
                    }
                }
                
                
            }
            .onAppear(perform: {
                contactsMgr.listContacts {
                    print("got all contacts")
                }
            })
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
    

}
