//
//  ContentView.swift
//  Pangea
//
//  Created by Luca on 02.07.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        MessageListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
