//
//  MessageListManager.swift
//  Pangea
//
//  Created by Mattso on 06/10/2021.
//

import Foundation

class MessageListManager {
    
    let convMgr = ConversationManager()
    var messages = [Messages]()
    
    func loadConversations() {
        convMgr.msgListMgr = self
        convMgr.getContactList()
    }
    
    func loadMessages(_ newMessages: [Messages]?) {
        if let newMessages = newMessages {
            handleReload(newMessages)
        }
        observeMessageActions()
    }
    
    func handleReload(_ newMessages: [Messages]) {
        messages = newMessages
        if messages.count != 0 {
            print("empty")
        }
        
        messages.sort { (message1, message2) -> Bool in
            return message1.time.intValue > message2.time.intValue
        }
        
        //reloadData()
    }
    
    func observeMessageActions() {
        convMgr.observeDeletedMessages()
        convMgr.observeNewMessages { (newMessages) in
            self.handleReload(newMessages)
        }
    }
}
