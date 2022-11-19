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
    @State var filter = ["Course code", "A"]
    @State var filter_true = ["Course code", "A"]
    let coursesData = loadCourse()
    

    var body: some View {
        
        var courses = coursesData.sorted(by: {
            if filter[0] == "Course code" {
                if filter[1] == "A" {
                    return $0.csub == $1.csub ? $0.cnum < $1.cnum : $0.csub < $1.csub
                }
                return $0.csub == $1.csub ? $0.cnum > $1.cnum : $0.csub > $1.csub
            } else if filter[0] == "Course title" {
                return filter[1] == "A" ? $0.title < $1.title : $0.title > $1.title
            }
            return filter[1] == "A" ? $0.title < $1.title : $0.title > $1.title
        })
        
        NavigationView {
            VStack (spacing: 0) {
                HStack {
                    //Button - Cancel<->Back Switching Mechanism
                    Button{
                        if showSheet {
                            filter = filter_true
                            showSheet.toggle()
                        } else {
                            menu = menuselect[0]
                        }
                    } label: {
                        if showSheet {
                            Text("Cancel")
                                .foregroundColor(ColorAux1)
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
                            filter_true = filter
                        }
                        showSheet.toggle()
                    } label: {
                        if showSheet {
                            Text("Apply")
                                .foregroundColor(ColorAux1)
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
                    .font(.system(size: 38))
                    .foregroundColor(ColorAux4)
                    .bold()
                
                if showSheet {
                    //Call Filter Config view
                    ListFilter(filter: $filter)
                } else {
                    //Show back CourseList default view
                    VStack {
                        SemSelect(sem: $sem)    //HeaderButtons
                        
                        ScrollView {
                           ForEach(courses) { course in
                               if course.sem == sem {
                                   Rectangle()
                                        .frame(width: .infinity, height: 1)
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
