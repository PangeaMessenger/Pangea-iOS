//
//  AddContactManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation
import Firebase

class ContactRequestManager {
    
    var groupedUsers = [String:ContactInfo]()
    var contactKeys = [String]()
    var ctrl = AddContactView()
    
    func loadRequests(completion: @escaping() -> Void) {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observeSingleEvent(of: .value) { (snap) in
            guard let values = snap.value as? [String:Any] else {return completion()}
            self.contactKeys.append(contentsOf: Array(values.keys))
            return completion()
        }
    }
    
    func setupRequests(_ completion: @escaping () -> Void) {
        loadRequests {
            if self.contactKeys.count == 0 {return completion()}
            self.fetchUsers()
        }
    }
    
    func fetchUsers() {
        for key in contactKeys {
            Database.database().reference().child("users").child(key).observeSingleEvent(of: .value) { (snap) in
                guard let values = snap.value as? [String:Any] else {return}
                self.setupContactInfo(for: key, values)
                self.ctrl.contactRequests = Array(self.groupedUsers.values)
                self.ctrl.contactRequests.sort { (contact1, contact2) -> Bool in
                    return contact1.name ?? "" < contact2.name ?? ""
                }
            }
        }
    }
    
    func setupContactInfo(for key: String, _ values: [String:Any]) {
        var contact = ContactInfo()
        contact.id = key
        contact.email = values["email"] as? String
        contact.profileImage = values["profileImage"] as? String
        contact.name = values["name"] as? String
        contact.isOnline = values["isOnline"] as? Bool
        contact.lastLogin = values["lastLogin"] as? NSNumber
        groupedUsers[key] = contact
    }
    
    func addAsContact(_ contact: ContactInfo, completion: @escaping () -> Void) {
        guard let id = contact.id else {return}
        let userRef = Database.database().reference().child("contactsList").child(CurrentUser.uid).child(id).child(id)
        let contactRef = Database.database().reference().child("contactsList").child(id).child(CurrentUser.uid).child(CurrentUser.uid)
        userRef.setValue(true)
        contactRef.setValue(true)
        self.removeRequestFromDB(contact) {
            return completion()
        }
    }
    
    func declineRequest(_ userToDelete: ContactInfo, completion: @escaping () -> Void) {
        self.removeRequestFromDB(userToDelete) {
            return completion()
        }
    }
    
    func removeRequestFromDB(_ user: ContactInfo, completion: @escaping () -> Void) {
        self.groupedUsers.removeValue(forKey: user.id ?? "")
        Database.database().reference().child("contactsList").child(CurrentUser.uid).child(user.id ?? "").child(user.id ?? "").removeValue { (error, ref) in
            Database.database().reference().child("contactsList").child(user.id ?? "").child(CurrentUser.uid).child(CurrentUser.uid).removeValue()
            return completion()
        }
    }
    
}
