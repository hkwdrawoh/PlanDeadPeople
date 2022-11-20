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
    
    init(filter: Binding<[String]>) {
        self._filter = filter
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(ColorMain2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(ColorAux1)], for: .selected)
//        UISegmentedControl.appearance().tintColor = UIColor(ColorMain2)
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                Text("Filter")
                    .font(.title)
                HStack {
                    Text("Sorted by:")
                        .font(.title2)
                    Spacer()
                }
                HStack {
                    Picker("", selection: $filter[0]) {
                        ForEach(["Course code", "Course title"], id: \.self) {
                            Text($0)
                        }
                    }
                    Spacer()
                    Picker("", selection: $filter[1]) {
                        ForEach(["A", "D"], id: \.self) {
                            if $0 == "A" {
                                Text("Ascending")
                            } else {
                                Text("Descending")
                            }
                        }
                    }
                    .pickerStyle(.segmented)
                }
                HStack {
                    Text("\nFiltered by:")
                        .font(.title2)
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
