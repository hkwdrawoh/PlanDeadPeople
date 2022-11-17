//
//  DescriptionPage.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI
import CoreData

struct CourseDescription: View {
    
    var body: some View {
//        ScrollView {
            VStack {
                Spacer()
                Text("Goodbye World!")
                    .font(.title)
                    .foregroundColor(ColorAux4)
                    .frame(maxWidth: .infinity)
                Spacer()
            }
            .background(ColorMain4)
//        }
    }
}

struct CourseDescription_Preview: PreviewProvider {
    static var previews: some View {
        CourseDescription()
    }
}
