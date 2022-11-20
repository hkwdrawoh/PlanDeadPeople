//
//  ProfilePage.swift
//  plandeadppl
//
//  Created by Carson Chan on 20/11/2022.
//

import SwiftUI

struct ProfilePage: View {
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @Binding var course: Course
    @State var img = "default"
    @State var credit = 0
    //@State var clickedSetting: Bool
    
    var body: some View {
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        let timeslots = loadClass()
        let timeslot = timeslots[timeslots.firstIndex(where: {$0.cid == course.cid})!]
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack (spacing: 0) {
                ScrollView{
                    //Top button icon
                    HStack {
                        Spacer()
                        //Button - Settings
                        Button{}label: {
                            Image(systemName: "gearshape")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 22, height: 20)
                                .foregroundColor(ColorAux1)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 13)
                        .background(ColorMain2)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .background(ColorMain4)
                    
                    //Profile Pic
                    Image(img)
                    
                    //Name
                    Text("\(user.username)")
                        .font(.system(size: 38))
                        .foregroundColor(ColorAux4)
                        .bold()
                        .padding(.vertical, -5)
                    
                    //Degree
                    Text(user.degree)
                        .font(.system(size: 25))
                        .foregroundColor(ColorAux4)
                        .bold()
                        .padding(.vertical, -5)
                        .multilineTextAlignment(.center)
                    
                    //VStack Box for content
                    VStack{
                        //Credits Taken
                        Spacer()
                        HStack{
                            Text("Credits Taken")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 20))
                            Spacer()
                            Text("\(credit)/240 ").foregroundColor(ColorAux1)
                                .font(.system(size: 20))
                        }
                        .padding(.all, 5.0)
                        Rectangle()
                            .frame(height: 1)
                            .overlay(.white)
                        
                        //Course Wishlist Redirect
                        Button{}label: {
                            Text("Course Wishlist")
                                .font(.system(size: 20))
                                .foregroundColor(ColorAux1)
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing], 5.0)
                        Rectangle()
                            .frame(height: 1)
                            .overlay(.white)
                        
                        //Timetable history
                        Button{}label: {
                            Text("Timetable History")
                                .font(.system(size: 20))
                                .foregroundColor(ColorAux1)
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing], 5.0)
                        Rectangle()
                            .frame(height: 1)
                            .overlay(.white)
                        
                        //Profile Settings
                        Button{}label: {
                            Text("Profile Settings")
                                .font(.system(size: 20))
                                .foregroundColor(ColorAux1)
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing], 5.0)
                        Rectangle()
                            .frame(height: 1)
                            .overlay(.white)
                    }.background(ColorMain1)
                        .frame(height: 200, alignment: .center)
                        .padding(.all, 20.0)
                }
                //Banner Img
                Image("hkubanner")
                    .resizable(resizingMode: .stretch)
                    .aspectRatio(contentMode: .fit)
                    
            }
        }
    }
}


struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        let courses = loadCourse()
        ProfilePage(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[4]), course: .constant(courses[0]))
    }
}

