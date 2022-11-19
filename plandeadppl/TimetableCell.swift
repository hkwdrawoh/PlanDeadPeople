//
//  TimetableCell.swift
//  plandeadppl
//
//  Created by Hobo on 14/11/2022.
//

import Foundation
import SwiftUI

// Extract timeslots into individual cells, with header spacer ready
struct TimetableCell: View {
    @Binding var menu: String
    @Binding var course_desc: Course
    @Binding var weekday: String
    @Binding var editTimeslot: Bool
    @Binding var users: [User]
    @Binding var uid: String
    @State var deletedCell = false
    var timeslots: [TimeSlots]
    
    var body: some View {
        ForEach(timeslots) { timeslot in
            if (timeslot.cdate == weekday) {
                VStack {
                    let height = timeslot.height_down + 14
                    
                    // top separation
                    Spacer()
                        .frame(height: CGFloat(height))
                    EachCell(menu: $menu, course_desc: $course_desc, editTimeslot: $editTimeslot, users: $users, uid: $uid, timeslot: timeslot, div_num: timeslot.div_num, div_total: timeslot.div_total)
                }
            }
        }
    }
    
}

// construct timeslot cell, with corresponding left and right spacers
struct EachCell: View {
    
    @Binding var menu: String
    @Binding var course_desc: Course
    @Binding var editTimeslot: Bool
    @Binding var users: [User]
    @Binding var uid: String
    @State var deleted = false
    var timeslot: TimeSlots
    var div_num: Int
    var div_total: Int
    
    var body: some View {
        let courses = loadCourse()
        let course = courses[courses.firstIndex(where: {$0.cid == timeslot.cid})!]
        let maxHeight = CGFloat(78*(timeslot.cend - timeslot.cstart))-3
        HStack {
            Spacer()
                .frame(width: 65)
            
            // left separation
            ForEach(1..<div_num) { _ in
                Spacer()
                    .frame(maxWidth: .infinity)
                Spacer()
                    .frame(width: 3)
            }
            
            // actual cell
            Button(action: {
                if !editTimeslot {
                    course_desc = course
                    menu = menuselect[3]
                }
            }) {
                ZStack {
                    VStack (alignment: .leading) {
                        Text("\(course.csub) \(course.cnum)\n\(course.loc)\(course.room)")
                            .bold()
                            .font(.title3)
                            .foregroundColor(ColorAux1)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: maxHeight, alignment: .leading)
                    .background(ColorMain1a)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).fill(ColorMain2).mask(
                            HStack {
                                Rectangle().frame(width: 10)
                                Spacer()
                            }
                        )
                        .allowsHitTesting(false)
                    )
                    
                    // dotted lines overlay
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(style: div_total != 1 ? StrokeStyle(lineWidth: 3, dash: [7]) : StrokeStyle(lineWidth: 0))
                        .foregroundColor(ColorAux3)
                        .allowsHitTesting(false)
                        .frame(maxWidth: .infinity, maxHeight: maxHeight, alignment: .leading)
                    
                    if editTimeslot {
                        VStack (alignment: .center) {
                            Spacer()
                            Button(action: {
                                if deleted {
                                    addClassTimetable(course, users[users.firstIndex(where: {$0.uid == uid})!])
                                    deleted.toggle()
                                } else {
                                    removeClassTimetable(course, users[users.firstIndex(where: {$0.uid == uid})!])
                                    deleted.toggle()
                                }
                            }) {
                                if deleted {
                                    HStack {
                                        Spacer()
                                        Text("DELETE")
                                            .bold()
                                            .font(.title3)
                                            .foregroundColor(ColorAux1)
                                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                                        Spacer()
                                        Spacer()
                                            .frame(width: 10)
                                    }
                                    .background(ColorAux3)
                                } else {
                                    HStack {
                                        Spacer()
                                        Text("STAY")
                                            .bold()
                                            .font(.title3)
                                            .foregroundColor(ColorAux3)
                                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                                        Spacer()
                                        Spacer()
                                            .frame(width: 10)
                                    }
                                    .background(ColorAux1)
                                }
                                
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: maxHeight, alignment: .center)
                        .cornerRadius(10)
                    }
                }
                .multilineTextAlignment(.leading)
            }
            
            // right separation
            ForEach(0..<(div_total - div_num)) { _ in
                Spacer()
                    .frame(width: 3)
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
                .frame(width: 2)
        }
    }
    
}
