//
//  WishlistPage.swift
//  plandeadppl
//
//  Created by Anthea Chan on 20/11/2022.
//

import SwiftUI
import UIKit

struct WishlistPage: View {
    
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course: Course
    
    let coursesData = loadCourse()
    
    var body: some View {
        
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                Text("Course Wishlist")
                    .font(.largeTitle)
                    .foregroundColor(ColorAux4)
                    .bold()
                ScrollView {
                    ForEach(coursesData) {item in
                        if checkWishlist(item, user) {
                            Rectangle()
                                 .frame(height: 1)
                            Button {
                                menu = menuselect[3]
                                course = item
                            } label: {
                                CourseRow(course: item)
                            }
                        }
                    }
                }
            }.foregroundColor(ColorAux4)
        }
    }
}

struct WishlistPage_Previews: PreviewProvider {
    static var previews: some View {
        let courses = loadCourse()
        let users = importUser()
        WishlistPage(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[4]), course: .constant(courses[0]))
    }
}
