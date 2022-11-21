//
//  MainMenu.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI

struct MainMenu: View {
    
    @State var uid = "guest"
    @State var users = importUser()
    @State var menu = menuselect[0]
    @State var course = loadCourse()[0]
    @State var flag1 = false
    @State var sem = "1"
    @State var weekday = "1"
    
    var body: some View {
        let classes = loadClass()
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        VStack(spacing: 0) {
            switch menu {
            case menuselect[0]:
                ScrollView{HomePage()}
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut, value: flag1)
            case menuselect[1]:
                CalendarList(uid: $uid, users: $users, menu: $menu, course_desc: $course, sem: $sem, weekday: $weekday, timeslots: genTimeSlot(classes, user, sem))
            case menuselect[2]:
                CourseList(uid: $uid, users: $users, menu: $menu, course_desc: $course)
            case menuselect[3]:
                CourseDescription(uid: $uid, users: $users, menu: $menu, course: $course, sem: $sem, weekday: $weekday, addedTimetable: checkClassinTimetable(course, user), addedWishlist: checkWishlist(course, user))
            case menuselect[4]:
                ProfilePage(uid: $uid,  users: $users, menu: $menu, course: $course)
            default:
                ScrollView{HomePage()}
            }
            
            HStack (alignment: .center) {
                Spacer()
                Button{
                    menu = menuselect[0]
                    flag1.toggle()
                } label: {
                    Image(systemName: "house.fill")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(10)
                    .background(menu == menuselect[0] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[1]} label: {
                    Image(systemName: "calendar.badge.clock")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 13)
                    .background(menu == menuselect[1] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[2]} label: {
                    Image(systemName: "text.book.closed.fill")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 37)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(menu == menuselect[2] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[3]} label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 37)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(menu == menuselect[3] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[4]} label: {
                    Image(systemName: "person.crop.circle")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(10)
                    .background(menu == menuselect[4] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Spacer()
            }
            .padding(.vertical, 10)
            .background(ColorMain1)
        }
        .background(ColorMain4)
    }
}

struct MainMenu_Preview: PreviewProvider {
    static var previews: some View {
        MainMenu()
    }
}
