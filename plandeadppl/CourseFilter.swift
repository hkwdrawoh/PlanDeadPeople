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
    @Binding var filter: [Bool]
    
    init(sort: Binding<[Bool]>, filter: Binding<[Bool]>) {
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
                        sort = sort_default
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
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(!sort[0] ? ColorAux1 : ColorAux4)
                            .background(!sort[0] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        sort[0] = true
                    }, label: {
                        Text("Course title")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
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
                        filter = filter_default
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
                
                // filtering wishlist
                Toggle("Wishlist Only:", isOn: $filter[0])
                    .padding(.horizontal)
                    .tint(ColorMain2)
                
                // filtering course sub
                HStack {
                    Text("Course subject:")
                        .padding(.horizontal)
                    Spacer()
                }
                
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: {
                        filter[1].toggle()
                    }, label: {
                        Text("ELEC")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[1] ? ColorAux1 : ColorAux4)
                            .background(filter[1] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        filter[2].toggle()
                    }, label: {
                        Text("ENGG")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[2] ? ColorAux1 : ColorAux4)
                            .background(filter[2] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                }
                
                // filtering course num
                HStack {
                    Text("Course level:")
                        .padding(.horizontal)
                    Spacer()
                }
                
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: {
                        filter[3].toggle()
                    }, label: {
                        Text("Level 1")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[3] ? ColorAux1 : ColorAux4)
                            .background(filter[3] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        filter[4].toggle()
                    }, label: {
                        Text("Level 2")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[4] ? ColorAux1 : ColorAux4)
                            .background(filter[4] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        filter[5].toggle()
                    }, label: {
                        Text("Level 3")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[5] ? ColorAux1 : ColorAux4)
                            .background(filter[5] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                }
                
                HStack (spacing: 0) {
                    Spacer()
                    Button(action: {
                        filter[6].toggle()
                    }, label: {
                        Text("Level 4")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[6] ? ColorAux1 : ColorAux4)
                            .background(filter[6] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                    Button(action: {
                        filter[7].toggle()
                    }, label: {
                        Text("Level 9")
                            .padding(.horizontal, 10)
                            .padding(.vertical, 8)
                            .foregroundColor(filter[7] ? ColorAux1 : ColorAux4)
                            .background(filter[7] ? ColorMain2 : ColorMain4)
                            .cornerRadius(50)
                    })
                    Spacer()
                }
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
        ListFilter(sort: .constant(sort_default), filter: .constant(filter_default))
    }
}
