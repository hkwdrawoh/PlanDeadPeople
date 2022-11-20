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
                    Button{
                        sort[0] = false
                        sort[1] = false
                    } label: {
                        Text("Reset")
                            .foregroundColor(ColorAux1)
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(ColorMain3)
                    .cornerRadius(10)
                }
                
                // sorting choices
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: {
                        sort[0] = false
                    }, label: {
                        Text("Course code")
                            .padding(8)
                            .foregroundColor(!sort[0] ? ColorAux1 : ColorAux4)
                            .background(!sort[0] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        sort[0] = true
                    }, label: {
                        Text("Course title")
                            .padding(8)
                            .foregroundColor(sort[0] ? ColorAux1 : ColorAux4)
                            .background(sort[0] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                }
                
                // sorting order
                Toggle(sort[1] ? "Descending" : "Ascending", isOn: $sort[1])
                    .padding(.horizontal)
                    .tint(ColorAux5)
            }
            .font(.title3)
            .padding(.bottom)
            
            VStack (alignment: .center) {
                // filtering sub-title
                HStack {
                    Text("Filtered by:")
                        .font(.title2)
                    Spacer()
                    Button{
                        sort[2] = false
                    } label: {
                        Text("Clear")
                            .foregroundColor(ColorAux1)
                            .font(.system(size: 18))
                            .bold()
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(ColorMain3)
                    .cornerRadius(10)
                }
                
                Toggle("Wishlist Only", isOn: $sort[2])
                    .padding(.horizontal)
                    .tint(ColorMain2)
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
        ListFilter(sort: .constant([false, false, false]), filter: .constant(["Course code", "A"]))
    }
}
