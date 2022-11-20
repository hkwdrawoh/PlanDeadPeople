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
    
    @Binding var menu: String
    @Binding var course_desc: Course
    @State var sem = "1"
    @State var showSheet = false
    @State var filter_proposed = ["Course code", "A"]
    @State var filter_true = ["Course code", "A"]
    @State var isWishlist = false
    
    let coursesData = loadCourse()
    

    var body: some View {
        let courses = filterCourse(coursesData, filter_true)
        NavigationView {
            VStack (spacing: 0) {
                HStack {
                    //Button - Cancel<->Back Switching Mechanism
                    Button{
                        if showSheet {
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
                        .background(ColorMain2)
                        .cornerRadius(10)
                    Spacer()
                    //Button - Filter<->Apply Switching Mechanism
                    Button{
                        if showSheet {
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
                            Image(systemName: "list.bullet.indent")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 22, height: 22)
                                .foregroundColor(ColorAux1)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain2)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Text("Course List")
                    .font(.largeTitle)
                    .foregroundColor(ColorAux4)
                    .bold()
                
                if showSheet {
                    //Call Filter Config view
                    ListFilter(filter: $filter_proposed)
                } else {
                    //Show back CourseList default view
                    VStack {
                        SemSelect(sem: $sem)    //HeaderButtons
                        
                        ScrollView {
                           ForEach(courses) { course in
                               if course.sem == sem {
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
                        .foregroundColor(ColorAux4)
                        .background(ColorMain4)
                    }
                }
            }
            .background(ColorMain4)
            .navigationBarHidden(true)
        }
    }

}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        let courses = loadCourse()
        CourseList(menu: .constant(menuselect[2]), course_desc: .constant(courses[0]))
    }
}
