//
//  TimetableLine.swift
//  plandeadppl
//
//  Created by Hobo on 11/11/2022.
//

import SwiftUI
import UIKit

struct TimetableView: View {
    
    var body: some View {
        VStack {
            ForEach(timediv, id: \.self) {div in
                HStack {
                    Spacer()
                        .frame(width: 5)
                    Text(div)
                        .frame(width: 50, height: 25)
                        .foregroundColor(ColorAux4)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(ColorAux4)
                }
                .padding(.bottom, 45)
            }
        }
        .background(ColorMain4)
    }

}


struct TimetableView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableView()
    }
}
