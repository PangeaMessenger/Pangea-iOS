//
//  MessageModel.swift
//  Pangea
//
//  Created by Mattso on 05/10/2021.
//

import Foundation

class Messages {
    
    var message: String!
    var sender: String!
    var recipient: String!
    var time: NSNumber!
    var mediaUrl: String!
    var audioUrl: String!
    var videoUrl: String!
    var storageID: String!
    var imageWidth: NSNumber!
    var imageHeight: NSNumber!
    var id: String!
    var repMessage: String!
    var repMediaMessage: String!
    var repMID: String!
    var repSender: String!
    
    func determineUser() -> String{
        if sender == CurrentUser.uid {
            return recipient
        }else{
            return sender
        }
    }
}
