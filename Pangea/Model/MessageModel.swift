//
//  MessageModel.swift
//  Pangea
//
//  Created by Luca on 17.07.21.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MessageModel: Codable, Identifiable, Hashable {
    @DocumentID var id : String?
    var message: String
    var user: String
    var timeStamp: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case user
        case timeStamp
    }
}
