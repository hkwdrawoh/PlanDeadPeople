//
//  Timetableview.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import CoreData
import UIKit

@available(iOS 16.0, *)
struct TimetableView: View {
    
    var body: some View {
        VStack {
            ForEach(timediv, id: \.self) {div in
                HStack {
                    Spacer()
                        .frame(width: 5)
                    Text(div)
                        .frame(width: 50)
                    Rectangle()
                        .frame(height: 1)
                }
                .padding(.bottom, 40)
            }
        }
        .background(ColorMain4)
    }

}


@available(iOS 16.0, *)
struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}
