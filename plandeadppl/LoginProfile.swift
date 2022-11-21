//
//  LoginProfile.swift
//  plandeadppl
//
//  Created by Carson Chan on 20/11/2022.
//

import SwiftUI

struct LoginProfile: View {
    @Binding var uid: String
    @Binding var users: [User]
    @Binding var showLoginPage: Bool
    @State var wrong_input = false
    @State var uid_input = ""
    @State var password_input = ""
    
    var body: some View {
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                // show course wishlist view
                HStack {
                    //Button - Settings
                    Button{
                        showLoginPage.toggle()
                    } label: {
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
                    
                    //Name
                    Text("Log in to enjoy many features!")
                        .font(.largeTitle)
                        .foregroundColor(ColorAux4)
                        .bold()
                        .padding(.vertical, -5)
                        .multilineTextAlignment(.center)
                    
                    //VStack Box for content
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Text("User ID:")
                                .padding(12)
                            Text("Password:")
                                .padding(12)
                        }
                        Spacer()
                        VStack (alignment: .trailing) {
                            TextField("User ID", text: $uid_input)
                                .keyboardType(.alphabet)
                                .padding(5)
                                .border(ColorAux4, width: 2)
                                .padding(5)
                                .autocorrectionDisabled(true)
                                .autocapitalization(.none)
                            SecureField("Password", text: $password_input)
                                .padding(5)
                                .border(ColorAux4, width: 2)
                                .padding(5)
                        }
                    }
                    .padding()
                    .font(.title2)
                    .foregroundColor(ColorAux4)
                    
                    if wrong_input {
                        Text("Wrong user ID / password.\nPlease try again.")
                            .font(.title3)
                            .foregroundColor(ColorAux3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    //Profile Settings
                    Button{
                        if let i = users.firstIndex(where: {$0.uid == uid_input}) {
                            if users[i].password == password_input && uid_input != "guest" {
                                wrong_input = false
                                uid = uid_input
                                showLoginPage = false
                            } else {
                                wrong_input = true
                            }
                        } else {
                            wrong_input = true
                        }
                    }label: {
                        Spacer()
                        Text("Log In")
                            .font(.title)
                            .foregroundColor(ColorAux1)
                        Spacer()
                    }
                    .padding(.vertical, 5)
                    .background(uid == "guest" ? ColorMain3 : ColorAux3)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
    }
}

struct LoginProfile_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        LoginProfile(uid: .constant("guest"), users: .constant(users), showLoginPage: .constant(true))
    }
}

