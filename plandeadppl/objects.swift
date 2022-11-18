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

// Time division
let timediv = ["08:30", "09:30", "10:30", "11:30", "12:30", "13:30", "14:30", "15:30", "16:30", "17:30", "18:30", "19:30", "20:30", "21:30"]

// Menu selection
let menuselect = ["Welcome", "CourseList", "CourseDetail", "Timetable", "Personal"]

// Building locations enum
enum Buildings: CaseIterable {
    case LE, MWT
    
    var name: String {
        switch self {
        case .LE: return "Library Extension"
        case .MWT: return "Meng Wah Theatre"
        }
    }
    
    var coordinates: (Float64, Float64) {
        switch self {
        case .LE: return (22.283309, 114.137784)
        case .MWT: return (22.282276, 114.139125)
        }
    }
}


// Courses: provide course details
class Course: Identifiable, Codable {
    var cid: Int16
    var csub: String
    var cnum: String
    var title: String
    var sem: String
    var classnum: String
    var desc: String
    var loc: String
    var room: String
    var prof: String
    
}

// Class TimeSlot: Generate timeslot in timetable
class TimeSlots: Identifiable {
    var cid: Int16
    var cdate: [String]
    var cstart: [Int]
    var cend: [Int]
    var div_total: Int
    var div_num: Int
    var height_down: [Int]
    
    init(_ cclass: CClass) {
        self.cid = cclass.cid
        self.cdate = cclass.cdate!
        self.cstart = cclass.cstart!
        self.cend = cclass.cend!
        self.div_total = 1
        self.div_num = 1
        self.height_down = []
        for i in 0..<cstart.count {
            self.height_down.append((78 * (cstart[i] - 8)))
        }
    }
    
    // check time crash function: compare two timeslots
    func check_crash(_ class2: TimeSlots) -> Bool {
        for i in 0..<cdate.count {
            if class2.cdate.contains(cdate[i]) {
                let j = class2.cdate.firstIndex(where: {$0 == cdate[i]})!
                if cstart[i] >= class2.cstart[j] && cstart[i] < class2.cend[j] {
                    return true
                }
                if class2.cstart[j] >= cstart[i] && class2.cstart[j] < cend[i] {
                    return true
                }
            }
        }
        return false
    }
    
    func returnString() -> String {
        var output: String = ""
        for i in 0..<cdate.count {
            output += "\(cdate[i]): \(cstart[i])-\(cend[i]), div: (\(div_total), \(div_num)), height: \(height_down[0])"
        }
        return output
    }
}

