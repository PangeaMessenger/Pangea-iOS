//
//  HomeModel.swift
//  Pangea
//
//  Created by Luca on 17.07.21.
//

import SwiftUI
import Foundation
import FirebaseFirestore

class HomeModel: ObservableObject {
    @Published var messages : [MessageModel] = []
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    
    init() {
        readAllMessages()
    }
    
    func onAppear(){
        // Checking wether user is joined already.
        if user == "" {
            // Join alert
            UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
        }
    }
        
    func alertView()->UIAlertController{
        let alert = UIAlertController(title: "Join Pangea", message: "Enter a nickname", preferredStyle: .alert)
        alert.addTextField { (txt) in
            txt.placeholder = "John Appleseed"
        }
        
        let join = UIAlertAction(title: "Join", style: .default) { (_) in
            // Checking for empty input/click
            let user = alert.textFields![0].text ?? ""
            if user != "" {
                self.user = user
                return
            }
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
        
        alert.addAction(join)
        return alert
    }
    
    func readAllMessages(){
        ref.collection("Messages").addSnapshotListener { (snap, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            
            guard let data = snap else { return }
            
            data.documentChanges.forEach { (doc) in
                if doc.type == .added {
                    let message = try! doc.document.data(as: MessageModel.self)!
                    DispatchQueue.main.async {
                        self.messages.append(message)
                    }
                }
            }
        }
    }
}
 
