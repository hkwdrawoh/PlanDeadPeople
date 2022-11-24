//
//  CoursePage.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//
// hi

import SwiftUI
import UIKit

// Course list main view
struct CourseList: View {
    
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course_desc: Course
    @State var sem = "1"
    @State var showSheet = false
    @State var sort_proposed = sort_default
    @State var sort_true = sort_default
    @State var filter_proposed = filter_default
    @State var filter_true = filter_default
    
    let coursesData = loadCourse()

    var body: some View {
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        let courses = filterCourse(user, coursesData, sort_true, filter_true)
        VStack (spacing: 0) {
            HStack {
                //Button - Cancel<->Back Switching Mechanism
                Button{
                    if showSheet {
                        sort_proposed = sort_true
                        filter_proposed = filter_true
                        showSheet.toggle()
                    } else {
                        menu = menuselect[0]
                    }
                } label: {
                    if showSheet {
                        Text("Cancel")
                            .foregroundColor(ColorAux1)
                            .font(.system(size: 18))
                            .bold()
                    } else {
                        Image(systemName: "arrow.uturn.backward")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
                    }
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain3)
                    .cornerRadius(10)
                Spacer()
                //Button - Filter<->Apply Switching Mechanism
                Button{
                    if showSheet {
                        sort_true = sort_proposed
                        filter_true = filter_proposed
                    }
                    showSheet.toggle()
                } label: {
                    if showSheet {
                        Text("Apply")
                            .foregroundColor(ColorAux1)
                            .font(.system(size: 18))
                            .bold()
                    } else {
                        Image(systemName: "slider.horizontal.3")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(ColorMain3)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            
            
            if showSheet {
                // Title
                Text("Course List - Filter")
                    .font(.largeTitle)
                    .foregroundColor(ColorAux4)
                    .bold()
                    .multilineTextAlignment(.center)
                
                //Call Filter Config view
                ListFilter(sort: $sort_proposed, filter: $filter_proposed)
            } else {
                // Title
                Text(filter_true != filter_default ? "Course List - Filtered" : "Course List")
                    .font(.largeTitle)
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.bottom)
                
                //Show back CourseList default view
                VStack {
                    if !filter_true[0] {
                        SemSelect(sem: $sem)    //HeaderButtons
                            .padding(.top, -10)
                    }
                    
                    ScrollView {
                        if courses.filter({return $0.sem == sem || filter_true[0]}).count == 0 {
                            Rectangle()
                                .frame(height: 1)
                            Text("\nNo courses found!")
                                .font(.title2)
                        } else {
                            ForEach(courses) { course in
                                if course.sem == sem || filter_true[0] {
                                    Rectangle()
                                        .frame(height: 1)
                                    Button {
                                        menu = menuselect[3]
                                        course_desc = course
                                    } label: {
                                        CourseRow(course: course)
                                    }
                                }
                            }
                        }
                    }
                    .foregroundColor(ColorAux4)
                    .background(ColorMain4)
                }
            }
        }
        .background(ColorMain4)
    }

}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        let courses = loadCourse()
        CourseList(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[2]), course_desc: .constant(courses[0]))
    }
}
