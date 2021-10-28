//
//  AddContactManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation
import Firebase

class ContactRequestManager: ObservableObject {
    
    var groupedUsers = [String:ContactInfo]()
    var contactKeys = [String]()
    var ctrl = AddContactView()
    var addMgr = AddContactManager()
    
    @Published var contactReqName: String = ""
    @Published var contactReqId: String = ""
    
    var currentUser = Auth.auth().currentUser
    
    func loadRequests(completion: @escaping () -> Void) {
        let parentRef = Database.database().reference().child("contactsList").child("contactRequests").child(currentUser?.uid ?? "")
        
        parentRef.observeSingleEvent(of: .value) { (snap) in
            print(snap)
            
            if (snap.value is NSNull) {
                print("No Requests Found")
                
                return completion()
            } else {
                for child in (snap.children) {
                    let user_snap = child as! DataSnapshot
                    let value = user_snap.value as! [String:String?]
                    
                    let name = value["contactName"] as? String
                    let id = value["contactId"] as? String
                    
                    print("Contact Request found from \(name) with id \(id)")
                    
                    self.contactReqName = name ?? ""
                    self.contactReqId = id ?? ""
                    
                    return completion()
                }
            }
        }
    }
    
    func acceptRequest(id: String, completion: @escaping () -> Void) {
        addMgr.findUser(id: id){
            print("Found User")
        }
        
        Database.database().reference().child("contactsList").child(currentUser?.uid ?? "").child(id).setValue(["contactId" : id, "contactName" : addMgr.usrName ?? "", "contactImg" : addMgr.usrProfileImg as? String])

        print("Added \(addMgr.contactName ?? "") to \(currentUser?.displayName ?? "")'s contact list")
        
        Database.database().reference().child("contactsList").child(id).child(currentUser?.uid ?? "").setValue(["contactId" : currentUser?.uid, "contactName" : currentUser?.displayName, "contactImg" : currentUser?.photoURL as? String])
        
        print("Added \(currentUser?.displayName ?? "") to \(addMgr.contactName ?? "")'s contact list")
        
        Database.database().reference().child("contactsList").child("contactRequests").child(currentUser?.uid ?? "").child(id).removeValue()
        
        print("removed \(addMgr.contactName ?? "")'s request from \(currentUser?.displayName ?? "")'s request database")
        
        return completion()
    }
    
}
