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
            CourseList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
