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
    @State var credit = 0
    @State var showWishlist = false
    @State var showProfileSetting = false
    @State var showLoginPage = false
    @State var showHistory = false
    
    var body: some View {
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        
        NavigationView {
            ZStack {
                ColorMain4.ignoresSafeArea()
                VStack (spacing: 0) {
                    // show course wishlist view
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
                            .background(ColorMain3)
                            .cornerRadius(10)
                            Spacer()
                        }
                        .padding(.horizontal)
                        .background(ColorMain4)
                        ScrollView {
                            WishlistPage(uid: $uid, users: $users, menu: $menu, course: $course)
                        }
                    
                    // show profile settings view
                    } else if showProfileSetting {
                        ProfileSetting(showProfileSetting: $showProfileSetting, menu: $menu, user: user)
                        
                    // show login page view
                    } else if showLoginPage {
                        LoginProfile(uid: $uid, users: $users, showLoginPage: $showLoginPage)
                        
                    // show timetable history page view
                    } else if showHistory {
                        HistoryList(uid: $uid, users: $users, menu: $menu, course_desc: $course, showHistory: $showHistory)
                    
                    // show main profile page view
                    } else {
                        VStack {
                            HStack {
                                Spacer()
                                //Button - Settings
                                Button{
                                    if uid == "guest" {
                                        showLoginPage.toggle()
                                    } else {
                                        showProfileSetting.toggle()
                                    }
                                } label: {
                                    Image(systemName: "gearshape")
                                        .resizable(resizingMode: .stretch)
                                        .frame(width: 22, height: 22)
                                        .foregroundColor(ColorAux1)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 12)
                                .background(ColorMain3)
                                .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            .background(ColorMain4)
                            
                            ScrollView {
                                //Profile Pic
                                HStack (spacing: 0) {
                                    user.picture
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 180, height: 180)
                                        .clipped()
                                        .aspectRatio(1, contentMode: .fit)
                                        .cornerRadius(8000)
                                        .padding(.bottom, 10)
                                }
                                
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
                                    if uid != "guest" {
                                        HStack{
                                            Text("Credits Taken")
                                                .foregroundColor(ColorAux1)
                                                .font(.title3)
                                            Spacer()
                                            Text("\(user.prev_credit)/240 ").foregroundColor(ColorAux1)
                                                .font(.title3)
                                        }
                                        .padding(.all, 5.0)
                                        Rectangle()
                                            .frame(height: 1)
                                            .overlay(.white)
                                        
                                    }
                                    
                                    //Credits Taken
                                    HStack{
                                        Text("Credits Taking")
                                            .foregroundColor(ColorAux1)
                                            .font(.title3)
                                        Spacer()
                                        Text("\((user.timetablesem1.count + user.timetablesem2.count + user.timetablesem3.count) * 6)/240 ").foregroundColor(ColorAux1)
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
                                    
                                    if uid != "guest" {
                                        Rectangle()
                                            .frame(height: 1)
                                            .overlay(.white)
                                        
                                        //Timetable history
                                        Button{showHistory = true}label: {
                                            Text("Timetable History")
                                                .font(.title3)
                                                .foregroundColor(ColorAux1)
                                            Spacer()
                                        }
                                        .padding(5)
                                    }
                                }
                                .padding()
                                .background(ColorMain1)
                                .cornerRadius(10)
                                .padding()
                                
                                //Profile Settings
                                Button{
                                    if uid == "guest" {
                                        showLoginPage.toggle()
                                    } else {
                                        uid = "guest"
                                    }
                                }label: {
                                    Spacer()
                                    if uid == "guest" {
                                        Text("Log In")
                                            .font(.title)
                                            .foregroundColor(ColorAux1)
                                    } else {
                                        Text("Sign Out")
                                            .font(.title)
                                            .foregroundColor(ColorAux1)
                                    }
                                    Spacer()
                                }
                                .padding(.vertical, 5)
                                .background(uid == "guest" ? ColorMain3 : ColorAux3)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .padding(.top, -10)
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
        ProfilePage(uid: .constant("hkwdrawoh"), users: .constant(users), menu: .constant(menuselect[4]), course: .constant(courses[0]))
    }
}

