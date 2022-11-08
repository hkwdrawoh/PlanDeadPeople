//
//  plandeadpplApp.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//

import SwiftUI

@main
struct plandeadpplApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
