//
//  ContactManager.swift
//  Pangea
//
//  Created by Mattso on 05/10/2021.
//

import FirebaseDatabase
import FirebaseAuth

class ContactManager {
    var contactsView: ContactsView!
    var contactKeys = [String]()
    var groupedContacts = [String: ContactInfo]()
    
    func observeContactList() {
        observeContactRequests()
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observeSingleEvent(of: .value) { (snap) in
            guard let contacts = snap.value as? [String:Any] else {
                self.observeContactActions()
                return
            }
            
            for dict in contacts.keys {
                self.contactKeys.append(dict)
            }
            
            self.getContactInfo()
        }
    }
    
    func observeContactActions() {
        observeNewContact()
        observeRemovedContacts()
    }
    
    func observeNewContact() {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observe(.childAdded) { (snap) in
            let contact = snap.key
            self.updateContactInfo(contact)
            let status = self.contactKeys.contains { (key) -> Bool in
                return contact ==  key
            }
            
            if status {
                return
            } else {
                self.contactKeys.append(contact)
            }
        }
    }
    
    func observeRemovedContacts() {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observe(.childRemoved) { (snap) in
            let contactToRemove = snap.key
            var index = 0
            for contact in Contacts.list {
                if contact.id == contactToRemove {
                    Contacts.list.remove(at: index)
                    self.removeContactFromArray(contactToRemove)
                    return
                }
                
                index += 1
            }
        }
    }
    
    func removeContactFromArray(_ contactToRemove: String) {
        var index = 0
        for contact in contactKeys {
            if contactToRemove == contact {
                contactKeys.remove(at: index)
            }
            
            index += 1
        }
    }
    
    func getContactInfo() {
        for key in contactKeys {
            Database.database().reference().child("users").child(key).observeSingleEvent(of: .value) { (snap) in
                guard let values = snap.value as? [String:Any] else {return}
                self.setupContactInfo(for: key, values)
                
                if key == self.contactKeys[self.contactKeys.count - 1] {
                    self.contactsView.handleReload(Array(self.groupedContacts.values))
                    self.observeContactActions()
                }
            }
        }
    }
    
    func updateContactInfo(_ key: String) {
        Database.database().reference().child("users").child(key).observe(.value) { (snap) in
            guard let values = snap.value as? [String: Any] else {return}
            self.setupContactInfo(for: key, values)
            self.contactsView.handleReload(Array(self.groupedContacts.values))
        }
    }
    
    func setupContactInfo(for key: String, _ values: [String: Any]) {
        var contact = ContactInfo()
        contact.id = key
        contact.email = values["email"] as? String
        contact.profileImage = values["profileImage"] as? String
        contact.name = values["name"] as? String
        contact.isOnline = values["isOnline"] as? Bool
        contact.lastLogin = values["lastLogin"] as? NSNumber
        
        groupedContacts[key] = contact
    }
    
    func observeContactRequests() {
        Database.database().reference().child("contactsList").child("contactRequests").child(CurrentUser.uid).observe(.value) { (snap) in
            
            let numOfRequests = Int(snap.childrenCount)
        }
    }
}
