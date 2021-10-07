//
//  AddContactView.swift
//  Pangea
//
//  Created by Mattso on 05/10/2021.
//

import SwiftUI
import Firebase

struct AddContactView: View {
    
    @State var userID: String = ""
    
    var contactRequests = [ContactInfo]()
    var mgr = AddContactManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Add a Contact")
                    .bold()
                    .font(.system(size: 30))
                
                TextField("Enter User ID", text: $userID)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 300)
                
                Button {
                    
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(.blue)
                            .frame(height: 100)
                        
                        Text("Search")
                            .bold()
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                }
                
                Spacer()
                
                Text("Pending Requests")
                    .bold()
                    .font(.system(size: 30))
                Divider()
                Text("No Pending Requests")
            }
        }
    }
    
    func findUser(id: String) {
        Database.database().reference().child("users").child(id).getData() { (error, snap) in
            
        }
    }
}
