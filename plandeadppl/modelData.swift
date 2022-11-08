//
//  modelData.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import Foundation
import CoreData

func importCourse(_ viewContext: NSManagedObjectContext) {
    for index in 1...20 {
        let newCourse = Course(context: viewContext)
        newCourse.id = UUID()
        newCourse.cid = Int16(index)
        newCourse.csub = "ELEC"
        newCourse.cnum = String(Int.random(in: 1001...4999))
        newCourse.title = "Mobile Application Development"
        newCourse.sem = ["1", "2", "S"].randomElement()
    }
}

func importUser(_ viewContext: NSManagedObjectContext) {
    for index in 1...20 {
        let newCourse = Course(context: viewContext)
        newCourse.id = UUID()
        newCourse.cid = Int16(index)
        newCourse.csub = "ELEC"
        newCourse.cnum = String(Int.random(in: 1001...4999))
        newCourse.title = "Mobile Application Development"
        newCourse.sem = ["1", "2", "S"].randomElement()
    }
}
