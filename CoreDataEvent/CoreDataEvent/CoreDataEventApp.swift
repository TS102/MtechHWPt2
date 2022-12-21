//
//  CoreDataEventApp.swift
//  CoreDataEvent
//
//  Created by Tyler Sun on 12/9/22.
//

import SwiftUI

@main
struct CoreDataEventApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
