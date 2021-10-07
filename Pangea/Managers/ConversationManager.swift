//
//  ConversationManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation
import Firebase

class ConversationManager {
    var groupedMessages = [String: Messages]()
    var unreadMessages = [String: Int]()
    var contactKeys = [String]()
    var totalUnread = Int()
    
    var msgListMgr: MessageListManager!
    
    func getContactList() {
        Database.database().reference().child("contactList").child(CurrentUser.uid).observeSingleEvent(of: .value) { (snap) in
            for child in snap.children {
                guard let snapshot = child as? DataSnapshot else {return}
                guard let contact = snapshot.value as? [String:Any] else {return}
                self.contactKeys.append(contentsOf: Array(contact.keys))
            }
            
            guard self.contactKeys.count > 0 else {
                self.msgListMgr.loadMessages(nil)
                return
            }
        }
    }
    
    func observeNewMessages(completion: @escaping (_ newMessages: [Messages]) -> Void) {
        for key in contactKeys {
            Database.database().reference().child("messages").child(CurrentUser.uid).child(key).queryLimited(toLast: 1).observe(.childAdded) { (snap) in
                
                guard let values = snap.value as? [String: Any] else {return}
                let message = ChatKit.setupUserMessage(for: values)
                
                let status = self.msgListMgr.messages.contains { (oldMessage) -> Bool in
                    return message.id == oldMessage.id
                }
                
                if status {
                    return
                } else {
                    self.groupedMessages[message.determineUser()] = message
                    return completion(Array(self.groupedMessages.values))
                }
            }
        }
        
        observeContactActions()
    }
    
    func observeDeletedMessages() {
        for key in contactKeys {
            Database.database().reference().child("messages").child(CurrentUser.uid).child(key).queryLimited(toLast: 1).observe(.childRemoved) { (snap) in
                
                guard let values = snap.value as? [String:Any] else {return}
                let message = ChatKit.setupUserMessage(for: values)
                self.groupedMessages.removeValue(forKey: message.determineUser())
                self.msgListMgr.messages = Array(self.groupedMessages.values)
            }
        }
    }
    
    func observeContactActions() {
        observeRemovedContacts()
        observeNewContacts()
    }
    
    func observeRemovedContacts() {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observe(.childRemoved) { (snap) in
            let contactToRemove = snap.key
            var index = 0
            for message in self.msgListMgr.messages {
                if message.determineUser() == contactToRemove {
                    self.groupedMessages.removeValue(forKey: contactToRemove)
                    self.msgListMgr.messages.remove(at: index)
                    self.removeContactFromArray(contactToRemove)
                    return
                }
                index += 1
            }
        }
    }
    
    func observeNewContacts() {
        Database.database().reference().child("contactsList").child(CurrentUser.uid).observe(.childAdded) { (snap) in
            let contactToAdd = snap.key
            let status = self.contactKeys.contains { (key) -> Bool in
                return key == contactToAdd
            }
            
            if status {
                return
            } else {
                self.contactKeys.append(contactToAdd)
                self.msgListMgr.observeMessageActions()
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
    
    func loadContacts(_ recent: Messages, completion: @escaping (_ contact: ContactInfo) -> Void) {
        let user = recent.determineUser()
        let ref = Database.database().reference().child("users").child(user)
        
        ref.observe(.value) { (snap) in
            guard let values = snap.value as? [String:Any] else {return}
            var contact = ContactInfo()
            contact.id = snap.key
            contact.name = values["name"] as? String
            contact.email = values["email"] as? String
            contact.isOnline = values["isOnline"] as? Bool
            contact.lastLogin = values["lastLogin"] as? NSNumber
            contact.profileImage = values["profilePicture"] as? String
            return completion(contact)
        }
    }
    
    func observeUserSeenMessage(_ contactId: String, completion: @escaping (_ userSeenMessagesCount: Int) -> Void) {
        let ref = Database.database().reference().child("messages").child("unreadMessages").child(contactId).child(CurrentUser.uid)
        ref.observe(.value) { (snap) in
            return completion(Int(snap.childrenCount))
        }
    }
    
    func observeUserIsTyping(_ contactId: String, completion: @escaping (_ isTyping: Bool, _ contactId: String) -> Void) {
        let ref = Database.database().reference().child("userActions").child(contactId).child(CurrentUser.uid)
        ref.observe(.value) { (snap) in
            guard let data = snap.value as? [String:Any] else {return}
            guard let isTyping = data["isTyping"] as? Bool else {return}
            guard let contactId = data["fromContact"] as? String else {return}
            
            return completion(isTyping, contactId)
        }
    }
    
    func stopMsgObserve() {
        for message in msgListMgr.messages {
            Database.database().reference().child("users").child(message.determineUser()).removeAllObservers()
        }
    }
    
    func observeUnreadMessages(_ key: String, completion: @escaping (_ unreadMessages: [String:Int]) -> Void) {
        Database.database().reference().child("messages").child("unreadMessages").child(CurrentUser.uid).child(key).observe(.value) { (snap) in
            self.totalUnread = 0
            self.unreadMessages[key] = Int(snap.childrenCount)
        }
    }
}
