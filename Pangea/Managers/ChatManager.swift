//
//  ChatManager.swift
//  Pangea
//
//  Created by Mattso on 26/09/2021.
//

import Foundation

struct ChatManager {
    var users: [String]
    var dictionary: [String:Any] {
        return ["users": users]
    }
}

extension ChatManager {
    init?(dictionary: [String:Any]) {
        guard let users = dictionary["users"] as? [String] else { return nil }
        
        self.init(users: users)
    }
}
