//
//  ContentView.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//
// hi

import SwiftUI
import CoreData
import UIKit

@available(iOS 16.0, *)
struct CourseList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Course.cnum, ascending: true)],
        animation: .default)
    private var Courses: FetchedResults<Course>
    @State var sem = "1"

    var body: some View {
        NavigationView {
            VStack {
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
                    .padding(.top, -15)
                
                HStack {
                    Group {
                        Button("Sem 1", action: {sem = "1"})
                        .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(sem == "1" ? ColorMain2 : ColorMain4)
                        
                        Button("Sem 2", action: {sem = "2"})
                        .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(sem == "2" ? ColorMain2 : ColorMain4)
                        
                        Button("Sem S", action: {sem = "S"})
                        .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(sem == "S" ? ColorMain2 : ColorMain4)
                    }
                    .cornerRadius(10)
                    .font(.title3)
                }
                .padding(.bottom, 5)
                .padding(.top, -15)
                
                ScrollView {
                   ForEach(Courses) { course in
                       if course.sem == sem {
                           Rectangle()
                                .frame(width: .infinity, height: 1)
                           NavigationLink(destination: CourseRow(course: course)) {
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

@available(iOS 16.0, *)
struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}