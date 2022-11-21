//
//  DescriptionPage.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI
import MapKit
import Contacts

struct CourseDescription: View {
    
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course: Course
    @Binding var sem: String
    @Binding var weekday: String
    @State var addedTimetable: Bool
    @State var addedWishlist: Bool
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State var locationName=""
    @State var showAlert = false
    @State var errorTitle=""
    @State var errorMessage=""
    @State var result=""
    @State var mapItem:MKMapItem?
    @State var placemark:CLPlacemark?
    
    var body: some View {
        
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        let timeslots = loadClass()
        let timeslot = timeslots[timeslots.firstIndex(where: {$0.cid == course.cid})!]
        
        VStack (spacing: 0) {
            
            //Top button icon
            HStack {
                //Button - Back
                Button{menu = menuselect[2]} label: {
                    Image(systemName: "arrow.uturn.backward")
                        .resizable(resizingMode: .stretch)
                        .frame(width: 22, height: 22)
                        .foregroundColor(ColorAux1)
                }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain3)
                    .cornerRadius(10)
                Spacer()
                //Button - Add to fav
                Button{
                    if addedWishlist {
                        removeWishlist(course, user)
                        addedWishlist = false
                    } else {
                        addWishlist(course, user)
                        addedWishlist = true
                    }
                } label: {
                    if addedWishlist{
                        Image(systemName: "heart.fill")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 20)
                            .foregroundColor(ColorAux1)
                    }
                    else {
                        Image(systemName: "heart")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 20)
                            .foregroundColor(ColorAux1)
                    }
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 13)
                .background(ColorMain3)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .background(ColorMain4)
            
            //Show content of selected course in ScrollView format, HStack to pack them tgt
            ScrollView {
                
                Text("\(course.csub) \(course.cnum)")
                    .font(.largeTitle)
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.vertical, -5)
                
                Text(course.title)
                    .font(.title)
                    .foregroundColor(ColorAux4)
                    .bold()
                    .padding(.vertical, -5)
                    .multilineTextAlignment(.center)
                
                //HStack for Teacher
                HStack {
                    Text("Teacher: "+course.prof)
                        .font(.title3)
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()}
                
                //Hstack for Location and Button Placement
                HStack (alignment: .center) {
                    Text("Location: \(course.loc)\(course.room)")
                        .font(.title3)
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10)
                    Button{
                        for place in Buildings.allCases {
                            let value = place
                            let str = String(describing: value)
                            if str == course.loc {
                                let lat = value.coordinates.0
                                let long = value.coordinates.1
                                locationName = value.name
                                let url = URL(string: "http://maps.apple.com/?daddr=\(lat),\(long)")
                                if UIApplication.shared.canOpenURL(url!) {
                                    UIApplication.shared.open(url!)
                                }
                            }
                            if let m = mapItem {
                                m.openInMaps()
                            }
                        }
                    } label: {
                        Image(systemName: "map")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 22, height: 22)
                            .foregroundColor(ColorAux1)
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 8)
                    .background(ColorMain3)
                    .cornerRadius(10)
                    Spacer()}
                
                //HStack for class timeslot
                HStack {
                    Text("Time: (Sem \(course.sem)) \(dayname[Int(timeslot.cdate)!-1]) \(timeslot.cstart):30-\(timeslot.cend):20")
                        .font(.title3)
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()
                }
                
                //HStack for course desc header
                HStack {
                    Text("Description: ")
                        .font(.title3)
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()}
                
                //HStack for course desc_full
                HStack {
                    Text(course.desc)
                        .font(.title3)
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 10.0)
                        .padding(.top, 5)
                    Spacer()
                }
            }
            .background(ColorMain4)
            
            //Add to Timetable Button
            Button{
                if addedTimetable {
                    sem = course.sem
                    weekday = timeslot.cdate
                    menu = menuselect[1]
                } else {
                    addClassTimetable(course, user)
                    addedTimetable = checkClassinTimetable(course, user)
                }
            } label: {
                HStack{
                    Spacer()
                    if addedTimetable {
                        Text("Added - View Timetable")
                            .font(.title)
                            .foregroundColor(ColorAux1)
                            .padding(10)
                    } else {
                        Text("Add to Timetable")
                            .font(.title)
                            .foregroundColor(ColorAux1)
                            .padding(10)
                    }
                    Spacer()
                }
            }.background(ColorMain3)
        }
    }
    
    //Update MapPin address to selected enum lat, long
    func updateAddress(placemarks:[CLPlacemark]?,error:Error?) {
        mapItem = nil
        if error != nil {
            errorTitle = "Error"
            errorMessage = "Geo failed with error \(error!.localizedDescription)"
            showAlert = true
        }
        else if let marks = placemarks, marks.count > 0 {
            placemark = marks[0] as CLPlacemark
            if let address: CNPostalAddress = placemark!.postalAddress {
                let place = MKPlacemark (coordinate: placemark!.location!.coordinate, postalAddress: address)
                mapItem = MKMapItem(placemark: place)
                mapItem?.name = locationName
            }
        }
    }
}

struct CourseDescription_Preview: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        let courses = loadCourse()
        CourseDescription(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[3]), course: .constant(courses[0]), sem: .constant("1"), weekday: .constant("1"), addedTimetable: false, addedWishlist: false)
    }
}
