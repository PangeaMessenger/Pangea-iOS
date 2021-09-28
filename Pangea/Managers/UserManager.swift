//
//  UserManager.swift
//  Pangea
//
//  Created by Mattso on 26/09/2021.
//

import Foundation
import MessageKit

struct UserManager: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
