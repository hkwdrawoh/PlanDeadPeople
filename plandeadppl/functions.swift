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
    users.append(User("guest", "Guest", [1, 2, 3, 4, 5, 6], [13, 23, 24, 25], [46]))
    users.append(User("hkwdrawoh", "Howard Wan", [1, 2, 3, 4, 5, 6], [13, 23, 24, 25], [46]))
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

// check whether course / class already exists in user timetable
func checkClassinTimetable(_ course: Course, _ user: User) -> Bool {
    if course.sem == "1" {
        return user.timetablesem1.contains(course.cid)
    } else if course.sem == "2" {
        return user.timetablesem2.contains(course.cid)
    } else {
        return user.timetablesem3.contains(course.cid)
    }
}

// add course / class to the user timetable
func addClassTimetable(_ course: Course, _ user: User) -> () {
    if course.sem == "1" {
        if !user.timetablesem1.contains(course.cid) {
            user.timetablesem1.append(course.cid)
        }
    } else if course.sem == "2" {
        if !user.timetablesem2.contains(course.cid) {
            user.timetablesem2.append(course.cid)
        }
    } else {
        if !user.timetablesem3.contains(course.cid) {
            user.timetablesem3.append(course.cid)
        }
    }
}

// generate timeslot for each timetable
func genTimeSlot(_ classes: [CClass], _ timetable: [Int16]) -> [TimeSlots] {
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
