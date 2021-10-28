//
//  ContactManager.swift
//  Pangea
//
//  Created by Mattso on 05/10/2021.
//

import FirebaseDatabase
import FirebaseAuth

class ContactManager: ObservableObject {
    var contactsView: ContactsView!
    var contactKeys = [String]()
    var groupedContacts = [String: ContactInfo]()
    
    var currentUser = Auth.auth().currentUser
    
    @Published var contactNames: [String] = []
    @Published var contactIds: [String] = []
    
    func listContacts(completion: @escaping () -> Void) {
        Database.database().reference().child("contactsList").child(currentUser?.uid ?? "").observe(DataEventType.value) { (snap) in
            for contact in snap.children {
                let contactSnap = contact as! DataSnapshot
                let dict = contactSnap.value as! [String:String]
                
                let name = dict["contactName"]!
                let id = dict["contactId"]!
                
                print("found contact \(name) with id: \(id)")
                self.contactNames.append(name)
                self.contactIds.append(id)
            }
            
            return completion()
        }
    }
}
