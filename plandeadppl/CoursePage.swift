//
//  CoursePage.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//
// hi

import SwiftUI
import CoreData
import UIKit

struct CourseList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var menu: String
    @State var sem = "1"

    var body: some View {
        let courses = loadCourse(viewContext)!.sorted(by: {$0.csub! == $1.csub! ? $0.cnum! < $1.cnum! : $0.csub! < $1.csub!})
        
        NavigationView {
            VStack {
                HStack {
                    Button{menu = menuselect[0]} label: {
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
                        Image(systemName: "list.bullet.indent")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
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
                    .padding(.vertical, -5)
                
                SemSelect(sem: $sem)
                
                ScrollView {
                   ForEach(courses) { course in
                       if course.sem == sem {
                           Rectangle()
                                .frame(width: .infinity, height: 1)
                           Button {
                               menu = menuselect[3]
                               
                           } label: {
                               CourseRow(course: course)
                           }
                       }
                    }
                }
                .foregroundColor(ColorAux4)
                .background(ColorMain4)
            }
            .background(ColorMain4)
            
            .navigationBarHidden(true)
        }
    }

}

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList(menu: .constant(menuselect[2])).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
