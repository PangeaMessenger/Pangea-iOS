//
//  PangeaApp.swift
//  Pangea
//
//  Created by Luca on 02.07.21.
//

import SwiftUI

@main
struct PangeaApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
