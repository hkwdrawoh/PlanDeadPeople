//
//  HistoryList.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import UIKit


let classess = loadClass()
let history = User("hkwdrawoh", "", "", "", [9, 10, 11, 12, 15], [32, 33, 34, 35, 36], [46], [], "", 0, Image("test"))

struct HistoryList: View {
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course_desc: Course
    @Binding var showHistory: Bool
    @State var sem = "1"
    @State var weekday = "1"
    @State var timeslots = genTimeSlot(classess, history, "1")
    
    var body: some View {

        return VStack {
            ZStack {
                // Title
                Text("2021 - 2022")
                    .font(.title)
                    .foregroundColor(ColorAux4)
                    .bold()
                
                // Edit (change to Apply) button
                HStack {
                    Button{showHistory.toggle()} label: {
                        Image(systemName: "arrow.uturn.backward")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain3)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            // Sem selection button
            HStack {
                Group {
                    Button("Sem 1", action: {
                        sem = "1"
                        timeslots = genTimeSlot(classess, history, sem)
                    })
                    .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "1" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem 2", action: {
                        sem = "2"
                        timeslots = genTimeSlot(classess, history, sem)
                    })
                    .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "2" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem S", action: {
                        sem = "S"
                        timeslots = genTimeSlot(classess, history, sem)
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
            
            // Weekday selection button
            WeekdaySelect(weekday: $weekday)
            
            // Timetable View
            ScrollView {
                ZStack(alignment: .top) {
                    TimetableView()
                    TimetableCell(menu: $menu, course_desc: $course_desc, weekday: $weekday, editTimeslot: .constant(false), users: $users, uid: $uid, timeslots: timeslots)
                }
            }
        }
        .background(ColorMain4)
    }

}


struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        let courses = loadCourse()
        let users = importUser()
        HistoryList(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[1]), course_desc: .constant(courses[0]), showHistory: .constant(true))
    }
}
