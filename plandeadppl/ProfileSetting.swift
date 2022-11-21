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
    @State var editProfile = false
    @State var showImagePicker = false
    @State var selectedImageSource = UIImagePickerController.SourceType.photoLibrary
    @State var image: UIImage? = nil
    @State var imagestatus = "0"
    
    var body: some View {
        
        let username = user.username
        let studentid = user.studentid
        let degree = user.degree
        
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                
                HStack {
                    Button{
                        if editProfile {
                            user.username = username
                            user.studentid = studentid
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
                    if !editProfile {
                        Text("Settings")
                            .font(.title)
                            .foregroundColor(ColorAux4)
                            .bold()
                    }
                    Spacer()
                    Button{
                        editProfile.toggle()
                        imagestatus = "0"
                    } label: {
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
                    // image
                    user.picture
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(8000)
                        .padding(.bottom, 10)
                    
                    // remove / change image
                    HStack (spacing: 0) {
                        if editProfile {
                            Spacer()
                            Button(action: {
                                imagestatus = "1"
                                user.picture = Image("default")
                                editProfile.toggle()
                            }, label: {
                                Text("Remove Photo")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 8)
                                    .foregroundColor(ColorAux1)
                                    .background(ColorAux3)
                                    .cornerRadius(10)
                            })
                            Spacer()
                            Button(action: {
                                image = nil
                                selectedImageSource = .photoLibrary
                                showImagePicker = true
                            }, label: {
                                Text("Change Photo")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 8)
                                    .foregroundColor(ColorAux1)
                                    .background(ColorMain3)
                                    .cornerRadius(10)
                            })
                            Spacer()
                        } else if imagestatus == "-1" {
                            Text("No image imported. Please try again.")
                                .multilineTextAlignment(.center)
                                .padding(.vertical, 8)
                                .foregroundColor(ColorAux3)
                        } else if imagestatus == "1" {
                            Text("Photo removed successfully.")
                                .padding(.vertical, 8)
                                .foregroundColor(ColorAux4)
                        } else if imagestatus == "2" {
                            Text("Photo added successfully.")
                                .padding(.vertical, 8)
                                .foregroundColor(ColorAux4)
                        }
                    }
                    .padding(.bottom, 20)
                    
                    // personal info
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Text("User ID:")
                                .padding(12)
                            Text("User Name:")
                                .padding(12)
                            Text("Student ID:")
                                .padding(12)
                            Text("Degree:")
                                .padding(.vertical, editProfile ? 30 : 12)
                                .padding(.horizontal, 12)
                        }
                        Spacer()
                        VStack (alignment: .trailing) {
                            if editProfile {
                                Text(user.uid)
                                    .padding(12)
                                TextField("Enter your username", text: $user.username)
                                    .keyboardType(.alphabet)
                                    .frame(width: 150)
                                    .padding(5)
                                    .border(ColorAux4, width: 2)
                                    .padding(5)
                                    .autocorrectionDisabled(true)
                                    .autocapitalization(.none)
                                TextField("Enter your student id", text: $user.studentid)
                                    .keyboardType(.numberPad)
                                    .frame(width: 150)
                                    .padding(5)
                                    .border(ColorAux4, width: 2)
                                    .padding(5)
                                VStack {
                                    Picker("Enter your degree", selection: $user.degree) {
                                        ForEach(["BEng(CivE)", "BEng(CompSc)", "BEng(CE)", "BEng(EE)", "BEng(ElecE)", "BEng(IELM)", "BEng(ME)"], id: \.self) {
                                            Text($0).tag($0)
                                        }
                                    }
                                    .pickerStyle(.wheel)
                                    .frame(width: 150, height: 80, alignment: .center)
                                    .clipped()
                                    .compositingGroup()
                                    .padding(5)
                                    .border(ColorAux4, width: 2)
                                    .padding(5)
                                }
                                .zIndex(-2)
                            } else {
                                Text(user.uid)
                                    .padding(12)
                                Text(user.username)
                                    .padding(12)
                                Text(user.studentid)
                                    .padding(12)
                                Text(user.degree)
                                    .padding(12)
                            }
                        }
                    }
                    .foregroundColor(ColorAux4)
                }
                .font(.title2)
                .foregroundColor(ColorAux4)
            }
        }
        // image picker from library
        .sheet(isPresented: $showImagePicker, onDismiss: {
            user.picture = (image == nil) ? user.picture : Image(uiImage: image!)
            imagestatus = (image == nil) ? "-1" : "2"
            editProfile.toggle()
        }) {
            ImagePicker(image: self.$image, selectedSource: selectedImageSource)
        }
    }
}

struct ProfileSetting_Previews: PreviewProvider {
    static var previews: some View {
        let users = importUser()
        ProfileSetting(showProfileSetting: .constant(false), menu: .constant(menuselect[4]), user: users[users.firstIndex(where: {$0.uid == "hkwdrawoh"})!])
    }
}
