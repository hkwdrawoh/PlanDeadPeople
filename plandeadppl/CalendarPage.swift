//
//  CalendarPage.swift
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
    
    
    @State var usernow = User()
    @State var username = "guest"
    @State var sem = "1"
    @State var weekday = "1"
    
    var body: some View {
        
        for user in Users {
            if user.uid == username {
                usernow = user
            }
        }
        let classes = loadClass(viewContext)!
        var timeslots: [TimeSlots] = GenTimeSlot(classes, Array(1...17))

        return VStack {
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
            
            SemSelect(sem: $sem)
            
            WeekdaySelect(weekday: $weekday)
            
            ScrollView {
                ZStack(alignment: .top) {
                    TimetableView()
                    TimetableCell(weekday: $weekday, timeslots: timeslots)
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
