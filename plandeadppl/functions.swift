//
//  functions.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import Foundation

// import course to Course
func importCourse() -> [Course] {
    var courses: [Course] = []
    let pathString = Bundle.main.path(forResource: "CourseData", ofType: "json")
    if let path = pathString {
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            do {
                let courseData = try decoder.decode([Course].self, from: data)
                courses = courseData
            }
            catch {print(error)}
        }
        catch {print(error)}
    }
    return courses
}

// import user to User
func importUser() -> [User] {
    var users: [User] = []
    users.append(User("guest", "Guest", [1, 2, 3], [4, 5, 6], [7, 8, 9]))
    users.append(User("hkwdrawoh", "Howard Wan", [], [], []))
    return users
}

// import class to CClass
func importClass() -> [CClass] {
    var classes: [CClass] = []
    let pathString = Bundle.main.path(forResource: "ClassData", ofType: "json")
    if let path = pathString {
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            do {
                let classData = try decoder.decode([CClass].self, from: data)
                classes = classData
            }
            catch {print(error)}
        }
        catch {print(error)}
    }
    return classes
}

// load courses from Course
func loadCourse() -> [Course] {
    let courses = importCourse()
    return courses
}

// load classes from CClass
func loadClass() -> [CClass] {
    let classes = importClass()
    return classes
}

func refreshUser(_ users: [User], _ uid: String) -> User {
    for user in users {
        if user.uid == uid {
            return user
        }
    }
    return users[0]
}

// generate timeslot for each timetable
func GenTimeSlot(_ classes: [CClass], _ timetable: [Int16]) -> [TimeSlots] {
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
