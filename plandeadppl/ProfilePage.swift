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
    @State var showWishlist = false
    //@State var clickedSetting: Bool
    
    var body: some View {
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        let timeslots = loadClass()
        let timeslot = timeslots[timeslots.firstIndex(where: {$0.cid == course.cid})!]
        
        NavigationView {
            ZStack {
                ColorMain4.ignoresSafeArea()
                VStack (spacing: 0) {
                    if showWishlist {
                        HStack {
                            Button{showWishlist.toggle()} label: {
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
                        }
                        .padding(.horizontal)
                        .background(ColorMain4)
                        ScrollView {
                            WishlistPage(uid: $uid, users: $users, menu: $menu, course: $course)
                        }
                    } else {
                    
                        VStack {
                            HStack {
                                Spacer()
                                //Button - Settings
                                Button{} label: {
                                    Image(systemName: "gearshape")
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
                                //Profile Pic
                                Image(img)
                                    .cornerRadius(8000)
                                
                                //Name
                                Text("\(user.username)")
                                    .font(.largeTitle)
                                    .foregroundColor(ColorAux4)
                                    .bold()
                                    .padding(.vertical, -5)
                                
                                //Degree
                                Text(user.degree)
                                    .font(.title)
                                    .foregroundColor(ColorAux4)
                                    .bold()
                                    .padding(.vertical, -5)
                                    .multilineTextAlignment(.center)
                                
                                //VStack Box for content
                                VStack{
                                    //Credits Taken
                                    HStack{
                                        Text("Credits Taken")
                                            .foregroundColor(ColorAux1)
                                            .font(.title3)
                                        Spacer()
                                        Text("\(credit)/240 ").foregroundColor(ColorAux1)
                                            .font(.title3)
                                    }
                                    .padding(.all, 5.0)
                                    Rectangle()
                                        .frame(height: 1)
                                        .overlay(.white)
                                    
                                    //Course Wishlist Redirect
                                    Button{showWishlist = true} label: {
                                        Text("Course Wishlist")
                                            .font(.title3)
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
                                            .font(.title3)
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
                                            .font(.title3)
                                            .foregroundColor(ColorAux1)
                                        Spacer()
                                    }
                                    .padding([.top, .leading, .trailing], 5.0)
                                }
                                .padding()
                                .background(ColorMain1)
                                .cornerRadius(10)
                                .padding()
                            }
                            
                            //Banner Img
                            if !showWishlist {
                                Image("hkubanner")
                                    .resizable(resizingMode: .stretch)
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
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

