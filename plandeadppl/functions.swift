//
//  functions.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import Foundation
import CoreData

// import course to Course
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

// import user to User
func importUser(_ viewContext: NSManagedObjectContext) {
    for _ in 1..<2 {
        let newUser = User(context: viewContext)
        newUser.id = UUID()
        newUser.uid = "guest"
        newUser.uname = "Guest"
        newUser.timetablesem1 = [1, 2, 3, 4, 5, 6, 7, 8]
        newUser.timetablesem2 = [8, 7, 14, 16, 17, 19]
        newUser.timetablesem3 = [6, 9, 13, 21, 22, 24]
    }
}

// import class to CClass
func importClass(_ viewContext: NSManagedObjectContext) {
    for index in 1...40 {
        let newClass = CClass(context: viewContext)
        newClass.cid = Int16(index)
        newClass.classid = ["A", "B", "C"].randomElement()
        newClass.cdate = [["1", "2", "3", "4", "5", "6"].randomElement()!]
        newClass.cstart = [[9, 10, 11, 12, 13, 14, 15, 16, 17].randomElement()!]
        newClass.cend = [newClass.cstart![0]+2]
    }
}

// load courses from Course
func loadCourse(_ viewContext: NSManagedObjectContext) -> [Course]? {
    let Courses: NSFetchRequest<Course> = Course.fetchRequest()
    
    do {
        let courses = try viewContext.fetch(Courses) as [Course]
        return courses
    } catch {
        
    }
    return nil
}

// load classes from CClass
func loadClass(_ viewContext: NSManagedObjectContext) -> [CClass]? {
    let Classes: NSFetchRequest<CClass> = CClass.fetchRequest()
    
    do {
        let classes = try viewContext.fetch(Classes) as [CClass]
        return classes
    } catch {
        
    }
    return nil
}

// generate timeslot for each timetable
func GenTimeSlot(_ classes: [CClass], _ timetable: [Int]) -> [TimeSlots] {
    var timeslots: [TimeSlots] = []
    var timeslot1: TimeSlots
    for cid in timetable {
        for cclass in classes {
            if cclass.cid == cid {
                
                timeslot1 = TimeSlots(cclass)
                if timeslots.count != 0 {
                    for timeslot2 in timeslots {
                        if timeslot1.check_crash(timeslot2) {
                            timeslot1.div_total += 1
                            timeslot1.div_num += 1
                            timeslot2.div_total += 1
                        }
                    }
                }
                timeslots.append(timeslot1)
                
            }
        }
    }
    return timeslots
}
