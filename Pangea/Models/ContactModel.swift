//
//  ContactModel.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation

struct ContactInfo {
    
    var id: String?
    
    var name: String?
    
    var profileImage: String?
    
    var email: String?
    
    var isOnline: Bool?
    
    var lastLogin: NSNumber?
    
    func userCheck() -> Bool{
        if id == nil || name == nil || profileImage == nil, email == nil{
            return false
        }
        return true
    }
    
    
}

class Contacts {
    
    static var list = [ContactInfo]()
    
}

struct ContactActivity{
    
    let isTyping: Bool?
    
    let contactId: String?
    
    init(isTyping: Bool, contactId: String) {
        
        self.isTyping = isTyping
        self.contactId = contactId
        
    }
   
}
