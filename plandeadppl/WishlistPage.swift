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
        var courses = [Int16]()
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
            HStack {
                Button{menu = menuselect[4]} label: {
                    Image(systemName: "arrow.uturn.backward")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 22, height: 22)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain2)
                    .cornerRadius(10)
                Spacer()
            }
            .padding(.horizontal)
            .background(ColorMain4)
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
        }
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
