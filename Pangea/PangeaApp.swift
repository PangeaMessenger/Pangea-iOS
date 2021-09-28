//
//  PangeaApp.swift
//  Pangea
//
//  Created by Luca on 02.07.21.
//

import SwiftUI
import Firebase
import StreamChat

@main
struct PangeaApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

extension ChatClient {
    static var shared: ChatClient!
}
