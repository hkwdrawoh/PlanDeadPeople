//
//  CalendarPage.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import UIKit

struct CalendarList: View {
    
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course_desc: Course
    @State var username = "guest"
    @State var sem = "1"
    @State var weekday = "1"
    @State var timeslots: [TimeSlots]
    
    var body: some View {
        
        let classes = loadClass()
        let user = users[users.firstIndex(where: {$0.uid == uid})!]

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
                //Button - Edit (Action TBC)
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
            
            HStack {
                Group {
                    Button("Sem 1", action: {
                        sem = "1"
                        timeslots = genTimeSlot(classes, user.timetablesem1)
                    })
                    .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "1" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem 2", action: {
                        sem = "2"
                        timeslots = genTimeSlot(classes, user.timetablesem2)
                    })
                    .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "2" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem S", action: {
                        sem = "S"
                        timeslots = genTimeSlot(classes, user.timetablesem3)
                    })
                    .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "S" ? ColorMain2 : ColorMain4)
                }
                .cornerRadius(10)
                .font(.title3)
            }
            .padding(.bottom, 5)
            .padding(.top, 5)
            
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
        let classes = loadClass()
        let courses = loadCourse()
        let users = importUser()
        CalendarList(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[1]), course_desc: .constant(courses[0]), timeslots: genTimeSlot(classes, users[users.firstIndex(where: {$0.uid == "guest"})!].timetablesem1))
    }
}
