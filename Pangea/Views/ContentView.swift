//
//  ContentView.swift
//  Pangea
//
//  Created by Luca on 02.07.21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var isLoggedIn: Bool
    
    init() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    var body: some View {
        if isLoggedIn == true {
            MessageListView()
        } else {
            WelcomeView(isShowing: $isLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
