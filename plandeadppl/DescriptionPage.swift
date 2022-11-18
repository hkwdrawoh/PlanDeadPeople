//
//  DescriptionPage.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI
import CoreData

struct CourseDescription: View {
    
    @Binding var menu: String
    @Binding var course: Course
    
    var body: some View {
        VStack (spacing: 0) {
            HStack {
                Button{menu = menuselect[2]} label: {
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
                Button{} label: {
                    Image(systemName: "heart")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 22, height: 22)
                        .foregroundColor(ColorAux1)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(ColorMain2)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .background(ColorMain4)
            
            ScrollView {
                Text("\(course.csub) \(course.cnum)")
                    .font(.system(size: 38))
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.vertical, -5)
                Text(course.title)
                    .font(.system(size: 25))
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.vertical, -5)
                    .multilineTextAlignment(.center)
                HStack {
                    Text("Teacher: "+course.prof)
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()}
                HStack {
                    Text("Location: "+course.loc+course.room)
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10)
                    Button{} label: {
                        Image(systemName: "map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(ColorMain2)
                    .cornerRadius(10)
                    Spacer()}
                Text("Description: "+course.desc)
                    .font(.system(size: 20))
                    .foregroundColor(ColorAux4)
                    .padding(.all, 10.0)
                    .frame(maxWidth: .infinity)
                    
            }
            .background(ColorMain4)
        }
    }
}

struct CourseDescription_Preview: PreviewProvider {
    static var previews: some View {
        let courses = loadCourse()
        CourseDescription(menu: .constant(menuselect[3]), course: .constant(courses[0]))
    }
}
