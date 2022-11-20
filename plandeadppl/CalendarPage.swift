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
    @State var editTimeslot = false
    
    var body: some View {
        
        let classes = loadClass()
        let user = users[users.firstIndex(where: {$0.uid == uid})!]

        return VStack {
            ZStack {
                // Title
                Text("2022 - 2023")
                    .font(.title)
                    .foregroundColor(ColorAux4)
                    .bold()
                
                // Edit (change to Apply) button
                HStack {
                    /*
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
                     */
                    Spacer()
                    Button{
                        if editTimeslot {
                            if sem == "1" {
                                timeslots = genTimeSlot(classes, user.timetablesem1)
                            } else if sem == "2" {
                                timeslots = genTimeSlot(classes, user.timetablesem2)
                            } else {
                                timeslots = genTimeSlot(classes, user.timetablesem3)
                            }
                        }
                        editTimeslot.toggle()
                    } label: {
                        if editTimeslot {
                            Text("Delete")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 18))
                                .bold()
                        } else {
                            Text("Edit")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 18))
                                .bold()
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain2)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            
            // Sem selection button
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
                    .disabled(editTimeslot)
                    
                    Button("Sem 2", action: {
                        sem = "2"
                        timeslots = genTimeSlot(classes, user.timetablesem2)
                    })
                    .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "2" ? ColorMain2 : ColorMain4)
                    .disabled(editTimeslot)
                    
                    Button("Sem S", action: {
                        sem = "S"
                        timeslots = genTimeSlot(classes, user.timetablesem3)
                    })
                    .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "S" ? ColorMain2 : ColorMain4)
                    .disabled(editTimeslot)
                }
                .cornerRadius(10)
                .font(.title3)
            }
            .padding(.bottom, 5)
            .padding(.top, 5)
            
            // Weekday selection button
            WeekdaySelect(weekday: $weekday)
            
            // Timetable View
            ScrollView {
                ZStack(alignment: .top) {
                    TimetableView()
                    TimetableCell(menu: $menu, course_desc: $course_desc, weekday: $weekday, editTimeslot: $editTimeslot, users: $users, uid: $uid, timeslots: timeslots)
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
