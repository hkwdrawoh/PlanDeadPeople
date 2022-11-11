//
//  Timeslots.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import Foundation
import CoreData
import SwiftUI

@ViewBuilder
func GenTimeslot(_ Courses: FetchedResults<Course>, _ timetable: [Int]) -> some View {
    if timetable.count == 0 {
        Text("NULL")
    } else {
        ForEach(timetable, id: \.self) { cid in
            ForEach(Courses) { course in
                if course.cid == cid {
                    Text(course.csub! + " " + course.cnum!)
                }
            }
        }
    }
}
