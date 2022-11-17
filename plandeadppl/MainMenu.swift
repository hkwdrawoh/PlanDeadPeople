//
//  MainMenu.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI
import CoreData

struct MainMenu: View {
    
    @State var menu = menuselect[0]
    
    var body: some View {
        VStack(spacing: 0) {
            switch menu {
            case menuselect[0]:
                ScrollView{HomePage()}
            case menuselect[1]:
                CalendarList()
            case menuselect[2]:
                CourseList()
            case menuselect[3]:
                CourseList()
            case menuselect[4]:
                ScrollView{HomePage()}
            default:
                ScrollView{HomePage()}
            }
            HStack (alignment: .center) {
                Spacer()
                Button{menu = menuselect[0]} label: {
                    Image(systemName: "house.fill")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 45, height: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(10)
                    .background(menu == menuselect[0] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[1]} label: {
                    Image(systemName: "calendar.badge.clock")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 45, height: 39)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 13)
                    .background(menu == menuselect[1] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[2]} label: {
                    Image(systemName: "text.book.closed.fill")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 39, height: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                    .background(menu == menuselect[2] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[3]} label: {
                    Image(systemName: "doc.text.magnifyingglass")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 39, height: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 10)
                    .background(menu == menuselect[3] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Button{menu = menuselect[4]} label: {
                    Image(systemName: "person.crop.circle")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 45, height: 45)
                        .foregroundColor(ColorAux1)
                }
                    .padding(10)
                    .background(menu == menuselect[4] ? ColorMain2 : nil)
                    .cornerRadius(10)
                Spacer()
            }
            .padding(.vertical, 10)
            .background(ColorMain1)
        }
        .background(ColorMain4)
    }
}

struct MainMenu_Preview: PreviewProvider {
    static var previews: some View {
        MainMenu().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
