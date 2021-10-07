//
//  AddContactManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation
import Firebase

class AddContactManager {
    var contact: ContactInfo!
    var ctrl: AddContactView!
    
    func addAsContact() {
        let ref = Database.database().reference().child("contactsList").child("contactRequests").child(contact.id ?? "").child(CurrentUser.uid).child(CurrentUser.uid)
        
        ref.setValue(CurrentUser.uid)
    }
    
    func removeContact() {
        let userRef = Database.database().reference().child("contactsList").child(CurrentUser.uid).child(contact.id ?? "").child(contact.id ?? "")
        let contactRef = Database.database().reference().child("contactsList").child(contact.id ?? "").child(CurrentUser.uid).child(CurrentUser.uid)
        
        userRef.removeValue()
        contactRef.removeValue()
    }
    
    func checkContact() {
        checkForContactRequest {
            self.checkContacting()
        }
    }
    
    func checkContacting() {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).child(contact.id ?? "").observe(.value) { (snap) in
            
        }
    }
    
    func checkForContactRequest(completion: @escaping () -> Void) {
        Database.database().reference().child("contactsList").child("contactRequests").child(contact.id ?? "").child(CurrentUser.uid).observeSingleEvent(of: .value) { (snap) in
            guard let _ = snap.value as? [String:Any] else {return completion()}
        }
    }
}
