//
//  TimetableCell.swift
//  plandeadppl
//
//  Created by Hobo on 14/11/2022.
//

import Foundation
import SwiftUI

struct TimetableCell: View {
    
    @Binding var weekday: String
    var timeslots: [TimeSlots]
    
    var body: some View {
        ForEach(timeslots) { timeslot in
            if (timeslot.cdate[0] == weekday) {
                VStack {
                    let height = timeslot.height_down[0] + 14
//                    let height = 14
                    
                    // top separation
                    Spacer()
                        .frame(height: CGFloat(height))
                    EachCell(div_num: timeslot.div_num, div_total: timeslot.div_total, inText1: "\(timeslot.cid), \(height)", inText2: timeslot.returnString())
                }
            }
        }
    }
    
}

struct EachCell: View {
    
    var div_num: Int
    var div_total: Int
    var inText1: String
    var inText2: String
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 65)
            
            // left separation
            ForEach(1..<div_num) { _ in
                Spacer()
                    .frame(maxWidth: .infinity)
                Spacer()
                    .frame(width: 3)
            }
            
            // actual cell
            ZStack {
                VStack (alignment: .leading) {
                    Text(inText1+"\n"+inText2)
                        .bold()
                        .font(.title3)
                        .foregroundColor(ColorAux1)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 0))
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 78*2-3, alignment: .leading)
                .background(ColorMain1a)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10).fill(ColorMain2).mask(
                        HStack {
                            Rectangle().frame(width: 10)
                            Spacer()
                        }
                    )
                    .allowsHitTesting(false)
                )
                
                // dotted lines overlay
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: div_total != 1 ? StrokeStyle(lineWidth: 3, dash: [7]) : StrokeStyle(lineWidth: 0))
                    .foregroundColor(ColorAux3)
                    .allowsHitTesting(false)
                    .frame(maxWidth: .infinity, maxHeight: 78*2-3, alignment: .leading)
            }
            
            // right separation
            ForEach(0..<(div_total - div_num)) { _ in
                Spacer()
                    .frame(width: 3)
                Spacer()
                    .frame(maxWidth: .infinity)
            }
            
            Spacer()
                .frame(width: 2)
        }
    }
    
}
