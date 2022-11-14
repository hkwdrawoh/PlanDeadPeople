//
//  TimetableCell.swift
//  plandeadppl
//
//  Created by Hobo on 14/11/2022.
//

import Foundation
import SwiftUI

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
                            timeslot1.incdiv_new()
                            timeslot2.incdiv_old()
                        }
                    }
                }
                timeslots.append(timeslot1)
                
            }
        }
    }
    return timeslots
}
