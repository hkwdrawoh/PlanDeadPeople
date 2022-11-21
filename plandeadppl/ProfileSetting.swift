//
//  ProfileSetting.swift
//  plandeadppl
//
//  Created by Anthea Chan on 20/11/2022.
//

import SwiftUI

struct ProfileSetting: View {
    
    @Binding var showProfileSetting: Bool
    @Binding var menu: String
    @State var user: User
    @State var dummyUID = ""
    @State var editProfile = false
    var user2: User
    
    var body: some View {
        
        let username = user.username
//        let uid = ""
        let degree = user.degree
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                
                HStack {
                    Button{
                        if editProfile {
                            user.username = username
                            user.degree = degree
                            editProfile.toggle()
                        } else {
                            showProfileSetting.toggle()
                        }
                    } label: {
                        if editProfile {
                            Text("Cancel")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 18))
                                .bold()
                        } else {
                            Image(systemName: "arrow.uturn.backward")
                                .resizable(resizingMode: .stretch)
                                .frame(width: 22, height: 22)
                                .foregroundColor(ColorAux1)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain3)
                    .cornerRadius(10)
                    Spacer()
                    Button{editProfile.toggle()} label: {
                        if editProfile {
                            Text("Confirm")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 18))
                                .bold()
                        } else {
                            Text("Edit")
                                .foregroundColor(ColorAux1)
                                .font(.system(size: 18))
                                .bold()
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 12)
                    .background(ColorMain3)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .background(ColorMain4)
                
                ScrollView {
                    Image("default")
                        .resizable(resizingMode: .stretch)
                        .cornerRadius(8000)
                        .frame(width: 120, height: 120)
                        .padding(.bottom, 50)
                    HStack {
                        Text("Name:")
                        Spacer()
                        if editProfile {
                            TextField("Enter your username", text: $user.username)
                        } else {
                            Text(user.username)
                        }
                    }
                    .padding(.horizontal, 10.0)
                    HStack {
                        Text("UID:")
                        TextField("Enter your UID", text: $dummyUID)
                    }
                    .padding(.horizontal, 10.0)
                    HStack {
                        Text("Degree:")
                        Spacer()
                        if editProfile {
                            TextField("Enter your degree", text: $user.degree)
                        } else {
                            Text(user.degree)
                        }
                    }
                    .padding(.horizontal, 10.0)
                }
            }
        }
    }
}

struct ProfileSetting_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        ProfileSetting(showProfileSetting: .constant(false), menu: .constant(menuselect[4]), user: users[users.firstIndex(where: {$0.uid == "guest"})!], user2: users[users.firstIndex(where: {$0.uid == "guest"})!])
    }
}
