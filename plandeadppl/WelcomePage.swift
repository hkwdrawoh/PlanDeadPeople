//
//  WelcomePage.swift
//  plandeadppl
//
//  Created by Anthea Chan on 11/11/2022.
//

import SwiftUI

struct HomePage: View {
    
    var body: some View {
        ZStack {
            ColorMain4.ignoresSafeArea()
            VStack {
                Text("Timetable Planner")
                    .font(.system(size: 35))
                    .foregroundColor(ColorAux4)
                    .bold()
                Text("Let's Survive This Year!")
                    .font(.system(size: 35))
                    .foregroundColor(ColorAux4)
                    .bold()
                Button(action: {
                    if let yourURL = URL(string: "https://elink.eee.hku.hk/eeelife.html") {
                            UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                    }
                }) {Image("WelcomeToEEE")
                        .resizable()
                        .frame(width: 350, height: 200, alignment: .center)
                }
                Button(action: {
                    if let yourURL = URL(string: "https://elink.eee.hku.hk/eeelife.html") {
                            UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                    }
                }) {Image("SomeTips")
                        .resizable()
                        .frame(width: 350, height: 200, alignment: .center)
                }
                Button(action: {
                    if let yourURL = URL(string: "https://elink.eee.hku.hk/eeelife.html") {
                            UIApplication.shared.open(yourURL, options: [:], completionHandler: nil)
                    }
                }) {Image("CheckOut")
                        .resizable()
                        .frame(width: 350, height: 200, alignment: .center)
                }
            }
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

