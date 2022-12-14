//
//  CourseRow.swift
//  plandeadppl
//
//  Created by Hobo on 8/11/2022.
//

import SwiftUI

struct CourseRow: View {
    var course: Course
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 3)
                Text(course.csub + " " + course.cnum)
                    .font(.title3)
                    .frame(width: 115)
                    .multilineTextAlignment(.leading)
                Text(course.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity)
        }
    }
}
