//
//  CourseRow.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import SwiftUI
import CoreData

struct CourseRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    var course: Course
    
    var body: some View {
        HStack {
            Text(course.csub! + " " + course.cnum!)
            Text(course.title!)
        }
        .frame(height: 50)
    }
}
