//
//  MessageManager.swift
//  Pangea
//
//  Created by Mattso on 12/07/2021.
//

import Foundation

class MessageManager: ObservableObject {
    var text = ""
    @Published var messageArray: [String] = []
    @Published var positionArray: [MessagePosition] = []
    @Published var position = MessagePosition.right
}