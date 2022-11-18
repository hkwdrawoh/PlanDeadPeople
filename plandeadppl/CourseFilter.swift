//
//  CourseFilter.swift
//  plandeadppl
//
//  Created by Hobo on 18/11/2022.
//

import Foundation
import SwiftUI

// Course List Filter view
struct ListFilter: View {
    
    @Binding var filter: [String]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Text("Filter")
                    .font(.system(size: 30))
                HStack {
                    Text("Sorted by:")
                        .font(.system(size: 22))
                    Spacer()
                }
                
            }
        }
        .padding()
        .background(ColorMain4)
        .foregroundColor(ColorAux4)
    }
}

struct ListFilter_Previews: PreviewProvider {
    static var previews: some View {
        ListFilter(filter: .constant(["Course code", "A"]))
    }
}
