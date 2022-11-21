//
//  objects.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import Foundation
import UIKit
import SwiftUI

// Color Tones
let ColorMain1 = Color(UIColor(red: 13/255, green: 47/255, blue: 48/255, alpha: 1))         //dark green
let ColorMain1a = Color(UIColor(red: 13/255, green: 47/255, blue: 48/255, alpha: 0.9))      //dark green transparent
let ColorMain2 = Color(UIColor(red: 0/255, green: 153/255, blue: 151/255, alpha: 1))        //tiffany blue
let ColorMain3 = Color(UIColor(red: 118/255, green: 194/255, blue: 166/255, alpha: 1))      //light green
let ColorMain4 = Color(UIColor(red: 207/255, green: 225/255, blue: 225/255, alpha: 1))      //pale green

let ColorAux1 = Color(UIColor(red: 1, green: 1, blue: 1, alpha: 1))                         //white
let ColorAux2 = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 1))                         //black
let ColorAux3 = Color(UIColor(red: 1, green: 0, blue: 0, alpha: 1))                         //red
let ColorAux4 = Color(UIColor(red: 13/255, green: 47/255, blue: 48/255, alpha: 1))          //dark green
let ColorAux5 = Color(UIColor(red: 194/255, green: 208/255, blue: 210/255, alpha: 1))       //grey

// Day Time division
let dayname = ["MON", "TUE", "WED", "THUR", "FRI", "SAT"]
let timediv = ["08:30", "09:30", "10:30", "11:30", "12:30", "13:30", "14:30", "15:30", "16:30", "17:30", "18:30", "19:30", "20:30", "21:30"]

// Menu selection
let menuselect = ["Welcome", "CourseList", "CourseDetail", "Timetable", "Personal"]

// Default sorting and filtering array
let sort_default = [false, false]
let filter_default = [false, true, true, true, true, true, true, true]

// Building locations enum
enum Buildings: CaseIterable {
    case LE, MWT, CB, MB, CYPP
    
    var name: String {
        switch self {
        case .LE: return "Library Extension"
        case .MWT: return "Meng Wah Theatre"
        case .CB: return "Chow Yei Ching Building"
        case .MB: return "Main Building"
        case .CYPP: return "Chong Yuet Ming Physics Building"
        }
    }
    
    var coordinates: (Float64, Float64) {
        switch self {
        case .LE: return (22.283309, 114.137784)
        case .MWT: return (22.282276, 114.139125)
        case .CB: return (22.283069, 114.135441)
        case .MB: return (22.283979, 114.137837)
        case .CYPP: return (22.283229, 114.139854)
        }
    }
}

// User: provide user stores details
class User: Identifiable, Codable {
    var uid: String
    var username: String
    var password: String
    var studentid: String
    var timetablesem1: [Int16]
    var timetablesem2: [Int16]
    var timetablesem3: [Int16]
    var wishlist: [Int16]
    var degree: String
    var prev_credit: Int
    
    init(_ uid: String, _ username: String, _ password: String, _ studentid: String, _ timetablesem1: [Int16], _ timetablesem2: [Int16], _ timetablesem3: [Int16], _ wishlist: [Int16], _ degree: String, _ prev_credit: Int) {
        self.uid = uid
        self.username = username
        self.password = password
        self.studentid = studentid
        self.timetablesem1 = timetablesem1
        self.timetablesem2 = timetablesem2
        self.timetablesem3 = timetablesem3
        self.wishlist = wishlist
        self.degree = degree
        self.prev_credit = prev_credit
    }
}

// Course: provide course details
class Course: Identifiable, Codable {
    var cid: Int16
    var csub: String
    var cnum: String
    var title: String
    var sem: String
    var desc: String
    var loc: String
    var room: String
    var prof: String
}

// CClass: provide class details
class CClass: Identifiable, Codable {
    var cid: Int16
    var classid: String
    var cdate: String
    var cstart: Int
    var cend: Int
}

// Class TimeSlot: Generate timeslot in timetable
class TimeSlots: Identifiable {
    var cid: Int16
    var cdate: String
    var cstart: Int
    var cend: Int
    var div_total: Int
    var div_num: Int
    var height_down: Int
    
    init(_ cclass: CClass) {
        self.cid = cclass.cid
        self.cdate = cclass.cdate
        self.cstart = cclass.cstart
        self.cend = cclass.cend
        self.div_total = 1
        self.div_num = 1
        self.height_down = 78 * (cstart - 8)
    }
    
    // check time crash function: compare two timeslots
    func check_crash(_ class2: TimeSlots) -> Bool {
        if class2.cdate == cdate {
            if cstart >= class2.cstart && cstart < class2.cend {
                return true
            }
            if class2.cstart >= cstart && class2.cstart < cend {
                return true
            }
        }
        return false
    }
    
    func returnString() -> String {
        return "\(cdate): \(cstart)-\(cend), div: (\(div_total), \(div_num)), height: \(height_down)"
    }
}

