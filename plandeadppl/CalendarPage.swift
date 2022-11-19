//
//  CalendarPage.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import UIKit

struct CalendarList: View {
    
    @Binding var menu: String
    @Binding var course_desc: Course
    @State var username = "guest"
    @State var sem = "1"
    @State var weekday = "1"
    
    var body: some View {
        
        let classes = loadClass()
        var timeslots: [TimeSlots] = GenTimeSlot(classes, Array(1...17))

        return VStack {
            HStack {
                Button{} label: {
                    Image(systemName: "arrow.uturn.backward")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 22, height: 22)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain2)
                    .cornerRadius(10)
                Spacer()
                Button{} label: {
                    Text("Edit")
                        .foregroundColor(ColorAux1)
                        .font(.system(size: 18))
                        .bold()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(ColorMain2)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            SemSelect(sem: $sem)
            
            WeekdaySelect(weekday: $weekday)
            
            ScrollView {
                ZStack(alignment: .top) {
                    TimetableView()
                    TimetableCell(menu: $menu, course_desc: $course_desc, weekday: $weekday, timeslots: timeslots)
                }
            }
        }
        .background(ColorMain4)
    }

}


struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        let courses = loadCourse()
        CalendarList(menu: .constant(menuselect[1]), course_desc: .constant(courses[0]))
    }
}
