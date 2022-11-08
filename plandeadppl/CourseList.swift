//
//  ContentView.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//

import SwiftUI
import CoreData
import UIKit

struct CourseList: View {
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(ColorMain4)
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Course.timestamp, ascending: true)],
        animation: .default)
    private var Courses: FetchedResults<Course>
    @State var sem = "1"

    var body: some View {
        NavigationView {
            VStack {
                Text("Course List")
                    .font(.system(size: 35))
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.top)
                
                HStack {
                    Group {
                        Button("Sem 1", action: {sem = "1"})
                        .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(sem == "1" ? ColorMain2 : ColorMain4)
                        
                        Button("Sem 2", action: {sem = "2"})
                        .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(sem == "2" ? ColorMain2 : ColorMain4)
                        
                        Button("Sem S", action: {sem = "S"})
                        .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(sem == "S" ? ColorMain2 : ColorMain4)
                    }
                    .cornerRadius(10)
                    .font(.title3)
                }
                
                List {
                   ForEach(Courses) { course in
                       NavigationLink(destination: CourseRow(course: course)) {
                           CourseRow(course: course)
                       }
                   }
                   .listRowBackground(ColorMain4)
               }
               .listStyle(.inset)
               .foregroundColor(ColorAux4)
            }
            .background(ColorMain4)
            
            .navigationBarHidden(true)
        }
    }

}

private let CourseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct CourseList_Previews: PreviewProvider {
    static var previews: some View {
        CourseList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
