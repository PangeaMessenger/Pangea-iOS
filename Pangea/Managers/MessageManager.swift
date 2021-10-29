//
//  MessageManager.swift
//  Pangea
//
//  Created by Mattso on 12/07/2021.
//

import Firebase

class MessageManager: ObservableObject {
    @Published var messageArray: [String] = []
    @Published var positionArray: [MessagePosition] = []
    @Published var position = MessagePosition.right
}
