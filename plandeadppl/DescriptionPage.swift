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
    
    @Binding var menu: String
    @Binding var course: Course
    
    @EnvironmentObject var locationManager: LocationManager
    
    @State var locationName=""
    @State var showAlert = false
    @State var errorTitle=""
    @State var errorMessage=""
    @State var result=""
    @State var mapItem:MKMapItem?
    @State var placemark:CLPlacemark?
    
    var body: some View {
        
        var dayname = ["MON", "TUE", "WED", "THUR", "FRI", "SAT"]
        
        let timeslots = loadClass()
        let timeslot = timeslots[timeslots.firstIndex(where: {$0.cid == course.cid})!]
        
        VStack (spacing: 0) {
            //Top button icon
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
            
            //Show content of selected course in ScrollView format, HStack to pack them tgt
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
                
                //HStack for Teacher
                HStack {
                    Text("Teacher: "+course.prof)
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()}
                
                //Hstack for Location and Button Placement
                HStack (alignment: .center) {
                    Text("Location: \(course.loc) \(course.room)")
                        .font(.system(size: 20))
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
                    .background(ColorMain2)
                    .cornerRadius(10)
                    Spacer()}
                
                HStack {
                    Text("Time: \(dayname[timeslots.firstIndex(where: {$0.cid == course.cid})!]) \(timeslot.cstart):30-\(timeslot.cend):20")
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()
                }
                
                //HStack for course desc header
                HStack {
                    Text("Description: ")
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading, .trailing], 10.0)
                    Spacer()}
                
                //HStack for course desc_full
                HStack {
                    Text(course.desc)
                        .font(.system(size: 20))
                        .foregroundColor(ColorAux4)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 10.0)
                        .padding(.top, 5)
                    Spacer()
                }
            }
            .background(ColorMain4)
            
            //Add to Planner Button (Pending Action TBC)
            Button{} label: {
                HStack{
                    Spacer()
                    Text("Add to Planner")
                        .font(.title2)
                        .foregroundColor(ColorAux1)
                        .multilineTextAlignment(.center)
                        .padding()
                    Spacer()
                }
            }.background(ColorMain2)
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
        let courses = loadCourse()
        CourseDescription(menu: .constant(menuselect[3]), course: .constant(courses[0]))
    }
}
