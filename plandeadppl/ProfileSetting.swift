//
//  ProfileSetting.swift
//  plandeadppl
//
//  Created by Anthea Chan on 20/11/2022.
//

import SwiftUI

struct ProfileSetting: View {
    
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var menu: String
    @State var dummyusername = ""
    @State var username = ""
    @State var dummyUID = ""
    @State var UID = ""
    @State var dummydegree = ""
    @State var degree = ""
    
    var body: some View {
        
        let user = users[users.firstIndex(where: {$0.uid == uid})!]
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                Image("default")
                    .cornerRadius(8000)
                    .padding(.all, 10.0)
                HStack {
                    Text("Username:")
                    TextField("Enter your username", text: $dummyusername)
                }
                .padding(.horizontal, 10.0)
                HStack {
                    Text("UID:")
                    TextField("Enter your UID", text: $dummyUID)
                }
                .padding(.horizontal, 10.0)
                HStack {
                    Text("Degree:")
                    TextField("Enter your degree", text: $dummydegree)
                }
                .padding(.horizontal, 10.0)
                HStack {
                    Button{
                        dummyusername = ""
                        dummyUID = ""
                        dummydegree = ""
                    } label: {
                        HStack {
                            Spacer()
                            Text("Clear Changes")
                                .foregroundColor(ColorAux1)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 10.0)
                    .background(ColorAux3)
                    
                    Button{
                        username = dummyusername
                        UID = dummyUID
                        degree = dummydegree
                        // need update user list function
                    } label: {
                        HStack {
                            Spacer()
                            Text("Confirm Changes")
                                .foregroundColor(ColorAux1)
                            Spacer()
                        }
                    }
                    .padding(.vertical, 10.0)
                    .background(ColorMain2)
                }
            }
        }
    }
}

struct ProfileSetting_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        let courses = loadCourse()
        ProfileSetting(uid: .constant("guest"), users: .constant(users), menu: .constant(menuselect[4]))
    }
}
