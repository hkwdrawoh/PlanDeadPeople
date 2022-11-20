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
    //@State var clickedSetting: Bool
    
    var body: some View {
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        let timeslots = loadClass()
        let timeslot = timeslots[timeslots.firstIndex(where: {$0.cid == course.cid})!]
        
        VStack (spacing: 0) {
            ScrollView{
                //Top button icon
                HStack {
                    //Button - Back (Maybe remove this button)
                    /*Button{menu = menuselect[2]} label: {
                     Image(systemName: "arrow.uturn.backward")
                     .resizable(resizingMode: .stretch)
                     .frame(width: 22, height: 22)
                     .foregroundColor(ColorAux1)
                     }
                     .padding(.horizontal, 12)
                     .padding(.vertical, 12)
                     .background(ColorMain2)
                     .cornerRadius(10)*/
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
                Image("")
                
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
                    HStack{
                        Text("Credits Taken")
                        Spacer()
                        Text("")
                    }
                    //Course Wishlist Redirect
                    Button{}label: {
                        Text("Course Wishlist")
                            .font(.system(size: 30))
                            .foregroundColor(ColorAux1)
                            .padding(10)
                    }
                    //Timetable history
                    Button{}label: {
                        Text("Timetable History")
                            .font(.system(size: 30))
                            .foregroundColor(ColorAux1)
                            .padding(10)
                    }
                    //Profile Settings
                    Button{}label: {
                        Text("Profile Settings")
                            .font(.system(size: 30))
                            .foregroundColor(ColorAux1)
                            .padding(10)
                    }
                }
                //Banner Img
            }
        }
    }
}


/*struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        let courses = loadCourse()
        ProfilePage(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[5]), course: .constant(courses[0]))
    }
}
*/
