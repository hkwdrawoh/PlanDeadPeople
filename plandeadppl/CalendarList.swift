//
//  CalendarList.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import CoreData
import UIKit

struct CalendarList: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.uid, ascending: true)],
        animation: .default)
    private var Users: FetchedResults<User>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Course.cid, ascending: true)],
        animation: .default)
    private var Courses: FetchedResults<Course>
    @State var sem = "1"
    @State var weekday = "1"
    
    var body: some View {
        VStack {
            HStack {
                Button{} label: {
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
                    Text("Edit")
                        .foregroundColor(ColorAux1)
                        .font(.system(size: 18))
                        .bold()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 12)
                .background(ColorMain2)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            
            HStack {
                Group {
                    Button("Sem 1", action: {sem = "1"})
                    .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "1" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem 2", action: {sem = "2"})
                    .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "2" ? ColorMain2 : ColorMain4)
                    
                    Button("Sem S", action: {sem = "S"})
                    .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 8)
                    .background(sem == "S" ? ColorMain2 : ColorMain4)
                }
                .cornerRadius(10)
                .font(.title3)
            }
            .padding(.bottom, 5)
            .padding(.top, 5)
            
            HStack {
                Group {
                    Button("Mon", action: {weekday = "1"})
                    .foregroundColor(weekday == "1" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "1" ? ColorMain2 : ColorMain4)
                    
                    Button("Tue", action: {weekday = "2"})
                    .foregroundColor(weekday == "2" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "2" ? ColorMain2 : ColorMain4)
                    
                    Button("Wed", action: {weekday = "3"})
                    .foregroundColor(weekday == "3" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "3" ? ColorMain2 : ColorMain4)
                    
                    Button("Thu", action: {weekday = "4"})
                    .foregroundColor(weekday == "4" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "4" ? ColorMain2 : ColorMain4)
                    
                    Button("Fri", action: {weekday = "5"})
                    .foregroundColor(weekday == "5" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "5" ? ColorMain2 : ColorMain4)
                    
                    Button("Sat", action: {weekday = "6"})
                    .foregroundColor(weekday == "6" ? ColorAux1 : ColorAux4)
                    .frame(width: 50)
                    .padding(.vertical, 8)
                    .background(weekday == "6" ? ColorMain2 : ColorMain4)
                }
                .cornerRadius(10)
                .font(.title3)
            }
            .padding(.bottom, 5)
            
            ScrollView {
                ZStack(alignment: .top) {
                    TimetableView()
                    ForEach(Users) { user in
                        if user.uid == "guest" {
                            if sem == "1" {
                                GenTimeslot(Courses, user.timetablesem1!)
                            } else if sem == "2" {
                                GenTimeslot(Courses, user.timetablesem2!)
                            } else {
                                GenTimeslot(Courses, user.timetablesem3!)
                            }
                        }
                    }
                }
            }
        }
        .background(ColorMain4)
    }

}


struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext).previewInterfaceOrientation(.portrait)
    }
}
