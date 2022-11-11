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
        newCourse.title = "Mobile Application Development Development Development"
        newCourse.sem = ["1", "2", "S"].randomElement()
        newCourse.classnum = newCourse.sem! + "A"
    }
    for index in 21...40 {
        let newCourse = Course(context: viewContext)
        newCourse.id = UUID()
        newCourse.cid = Int16(index)
        newCourse.csub = "ELEC"
        newCourse.cnum = String(Int.random(in: 1001...4999))
        newCourse.title = "Mobile Application Dev"
        newCourse.sem = ["1", "2", "S"].randomElement()
        newCourse.classnum = newCourse.sem! + "A"
    }
}

func importUser(_ viewContext: NSManagedObjectContext) {
    for _ in 1..<2 {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.uid = "guest"
        newUser.uname = "Guest"
        newUser.timetablesem1 = [1, 2, 3, 4, 5]
        newUser.timetablesem2 = [8, 7, 14, 16, 17, 19]
        newUser.timetablesem3 = [6, 9, 13, 21, 22, 24]
    }
}