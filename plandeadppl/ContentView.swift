//
//  ContentView.swift
//  plandeadppl
//
//  Created by Hobo on 7/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Course.timestamp, ascending: true)],
        animation: .default)
    private var Courses: FetchedResults<Course>

    var body: some View {
        NavigationView {
            List {
                ForEach(Courses) { Course in
                    NavigationLink {
                        Text("Course at \(Course.timestamp!, formatter: CourseFormatter)")
                    } label: {
                        Text(Course.timestamp!, formatter: CourseFormatter)
                    }
                }
                .onDelete(perform: deleteCourses)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addCourse) {
                        Label("Add Course", systemImage: "plus")
                    }
                }
            }
            Text("Select an Course")
        }
    }

    private func addCourse() {
        withAnimation {
            let newCourse = Course(context: viewContext)
            newCourse.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteCourses(offsets: IndexSet) {
        withAnimation {
            offsets.map { Courses[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let CourseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
