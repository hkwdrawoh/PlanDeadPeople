//
//  TimetableCell.swift
//  plandeadppl
//
//  Created by Hobo on 14/11/2022.
//

import Foundation
import SwiftUI

struct TimetableCell: View {
    @Binding var menu: String
    @Binding var course_desc: Course
    @Binding var weekday: String
    var timeslots: [TimeSlots]
    
    var body: some View {
        ForEach(timeslots) { timeslot in
            if (timeslot.cdate == weekday) {
                VStack {
                    let height = timeslot.height_down + 14
                    
                    // top separation
                    Spacer()
                        .frame(height: CGFloat(height))
                    EachCell(menu: $menu, course_desc: $course_desc, cid: timeslot.cid, div_num: timeslot.div_num, div_total: timeslot.div_total)
                }
            }
        }
    }
    
}


struct EachCell: View {
    
    @Binding var menu: String
    @Binding var course_desc: Course
    var cid: Int16
    var div_num: Int
    var div_total: Int
    
    var body: some View {
        let courses = loadCourse()
        let course = courses[courses.firstIndex(where: {$0.cid == cid})!]
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
                course_desc = course
                menu = menuselect[3]
            }) {
                ZStack {
                    VStack (alignment: .leading) {
                        Text("\(course.csub) \(course.cnum)\n\(course.loc) \(course.room)")
                            .bold()
                            .font(.title3)
                            .foregroundColor(ColorAux1)
                            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 78*2-3, alignment: .leading)
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
                        .frame(maxWidth: .infinity, maxHeight: 78*2-3, alignment: .leading)
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
