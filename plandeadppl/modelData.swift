//
//  modelData.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import Foundation
import CoreData

func importCourse(_ viewContext: NSManagedObjectContext) {
    for _ in 0..<20 {
        let newCourse = Course(context: viewContext)
        newCourse.timestamp = Date()
        newCourse.cid = UUID()
        newCourse.csub = "ELEC"
        newCourse.cnum = String(Int.random(in: 1001...4999))
        newCourse.title = "Mobile Application Development"
        newCourse.sem = ["1", "2", "S"].randomElement()
    }
}
