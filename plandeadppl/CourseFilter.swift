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
    
    @Binding var sort: [Bool]
    @Binding var filter: [String]
    @State var isWishlist = false
    
    init(sort: Binding<[Bool]>, filter: Binding<[String]>) {
        self._sort = sort
        self._filter = filter
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(ColorMain2)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(ColorAux1)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.font: UIFont.preferredFont(forTextStyle: .title2)], for: .normal)
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .center) {
                // sorting sub-title
                HStack {
                    Text("Sorted by:")
                        .font(.title2)
                    Spacer()
                }
                
                // sorting choices
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: {
                        sort[0] = false
                    }, label: {
                        Text("Course code")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .foregroundColor(!sort[0] ? ColorAux1 : ColorAux4)
                            .background(!sort[0] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        sort[0] = true
                    }, label: {
                        Text("Course title")
                            .padding(.horizontal)
                            .padding(.vertical, 5)
                            .foregroundColor(sort[0] ? ColorAux1 : ColorAux4)
                            .background(sort[0] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                }
                
                // sorting order
                Toggle(sort[1] ? "Descending" : "Ascending", isOn: $sort[1])
                    .padding(.horizontal)
            }
            .font(.title3)
            
            VStack (alignment: .center) {
                // filtering sub-title
                HStack {
                    Text("\nFiltered by:")
                        .font(.title2)
                    Spacer()
                }
                
                Toggle("Wishlist", isOn: $isWishlist)
                    .padding(.horizontal)
            }
            .font(.title3)
        }
        .padding()
        .background(ColorMain4)
        .foregroundColor(ColorAux4)
    }
}

struct ListFilter_Previews: PreviewProvider {
    static var previews: some View {
        ListFilter(sort: .constant([false, false]), filter: .constant(["Course code", "A"]))
    }
}
