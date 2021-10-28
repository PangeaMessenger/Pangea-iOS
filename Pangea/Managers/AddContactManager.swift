//
//  AddContactManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation
import Firebase

class AddContactManager: ObservableObject {
    var contact: ContactInfo!
    var ctrl: AddContactView!
    
    @Published var usrName: String? = ""
    @Published var usrProfileImg: URL = URL(string: "lol") as! URL
    @Published var usrId: String = ""
    
    @Published var contactId: String? = ""
    @Published var contactName: String? = ""
    
    func findUser(id: String, completion: @escaping () -> Void) {
        Database.database().reference().child("users").child(id).observeSingleEvent(of: .value) { (snap) in
            guard let value = snap.value as? [String:Any] else {return}
            let name = value["name"] as! String
            let profileImg = value["profileImg"] as! String
            
            self.usrName = name
            print("the user's name is \(self.usrName ?? "")")
    
            self.usrProfileImg = URL(string: profileImg) as! URL
            self.usrId = id
            
            return completion()
        }
    }
    
    func addAsContact() {
        if let currentUser = Auth.auth().currentUser {
            Database.database().reference().child("contactsList").child("contactRequests").child(usrId ?? "").child(currentUser.uid).setValue(["contactId" : currentUser.uid ?? "", "contactName" : currentUser.displayName ?? "", "contactProfileImg" : currentUser.photoURL as? String])
            
            print("\(currentUser.displayName) has sent \(usrName) a contact request")
        } else {
            print("An error has happened")
        }
    }
    
    func removeContact() {
        let userRef = Database.database().reference().child("contactsList").child(CurrentUser.uid).child(contact.id ?? "").child(contact.id ?? "")
        let contactRef = Database.database().reference().child("contactsList").child(contact.id ?? "").child(CurrentUser.uid).child(CurrentUser.uid)
        
        userRef.removeValue()
        contactRef.removeValue()
    }

    
    func checkForContactRequestId(completion: @escaping () -> Void) {
        Database.database().reference().child("contactsList").child("contactRequests").child(Auth.auth().currentUser?.uid ?? "").observeSingleEvent(of: .value) { (snap) in
            
            print(snap)
            
            if(snap.value is NSNull) {
                print("No data found")
            } else {
                for data in (snap.children) {
                    let usrData = data as! DataSnapshot
                    let dict = usrData.value as! [String:String?]
                    
                    let id = dict["contactId"] as? String
                    let name = dict["contactName"] as? String
                    
                    self.contactId = id
                    self.contactName = name
                }
            }
        }
    }
}
