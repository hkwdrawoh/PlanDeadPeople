//
//  DescriptionPage.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI
import CoreData
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
    
    enum places: CaseIterable {
        case LE, MWT
        
        var rawValue: (Float64, Float64) {
            switch self {
                case .LE: return (22.283309, 114.137784)
                case .MWT: return (22.282276, 114.139125)
            }
        }
    }
    
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
                    Button{
                        for place in places.allCases {
                            let value = place
                            let str = String(describing: value)
                            if str == course.loc {
                                var lat = value.rawValue.0
                                var long = value.rawValue.1
                                locationName = "\(lat),\(long)"
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
                Text(locationName)
                Text("Description: "+course.desc)
                    .font(.system(size: 20))
                    .foregroundColor(ColorAux4)
                    .padding(.all, 10.0)
                    .frame(maxWidth: .infinity)
                    
            }
            .background(ColorMain4)
        }
    }
    
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
