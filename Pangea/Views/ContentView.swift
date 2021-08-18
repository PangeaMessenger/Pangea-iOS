//
//  ContentView.swift
//  Pangea
//
//  Created by Luca on 02.07.21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    var body: some View {
        MessageListView()
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
      func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
