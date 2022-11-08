//
//  CourseRow.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import SwiftUI
import CoreData

struct CourseRow: View {
    var course: Course
    
    var body: some View {
        HStack {
            Text(course.csub! + " " + course.cnum!)
                .font(.system(size: 20))
                .frame(width: 110)
            Text(course.title!)
                .font(.system(size: 18))
        }
        .frame(height: 50)
    }
}
