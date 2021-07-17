//
//  HomeModel.swift
//  Pangea
//
//  Created by Luca on 17.07.21.
//

import SwiftUI
import Foundation

class HomeModel: ObservableObject {
    @Published var messages : [MessageModel] = []
    @AppStorage("current_user") var user = ""
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
        }
        
        alert.addAction(join)
        return alert
    }
}
 
