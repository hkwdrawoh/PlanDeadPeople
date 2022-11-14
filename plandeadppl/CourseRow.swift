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
        VStack {
            HStack {
                Spacer()
                    .frame(width: 3)
                Text(course.csub! + " " + course.cnum!)
                    .font(.system(size: 20))
                    .frame(width: 110)
                    .multilineTextAlignment(.leading)
                Text(course.title!)
                    .font(.system(size: 18))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
    }
}
