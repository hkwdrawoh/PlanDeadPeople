//
//  functions.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import Foundation
import CoreData

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
