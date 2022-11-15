//
//  TimetableCell.swift
//  plandeadppl
//
//  Created by Hobo on 14/11/2022.
//

import Foundation
import SwiftUI

func GenTimeSlot(_ classes: [CClass], _ timetable: [Int]) -> [TimeSlots] {
    var timeslots: [TimeSlots] = []
    var timeslot1: TimeSlots
    for cid in timetable {
        for cclass in classes {
            if cclass.cid == cid {
                
                timeslot1 = TimeSlots(cclass)
                if timeslots.count != 0 {
                    for timeslot2 in timeslots {
                        if timeslot1.check_crash(timeslot2) {
                            timeslot1.div_total += 1
                            timeslot1.div_num += 1
                            timeslot2.div_total += 1
                        }
                    }
                }
                timeslots.append(timeslot1)
                
            }
        }
    }
    return timeslots
}

struct TimetableCell: View {
    
    var timeslots: [TimeSlots]
    
    var body: some View {
        ForEach(timeslots) { timeslot in
            VStack {
                let height = timeslot.height_down[0] + 14
//                let height = 14
                Spacer()
                    .frame(height: CGFloat(height))
                HStack {
                    Spacer()
                        .frame(width: 65)
                    ForEach(1..<timeslot.div_num) { _ in
                        Spacer()
                            .frame(maxWidth: .infinity)
                        Spacer()
                            .frame(width: 2)
                    }
                    EachCell(inText1: "\(timeslot.cid), \(height)", inText2: timeslot.returnString())
                    ForEach(0..<(timeslot.div_total - timeslot.div_num)) { _ in
                        Spacer()
                            .frame(width: 2)
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
                    Spacer()
                        .frame(width: 2)
                }
            }
        }
    }
    
}

struct EachCell: View {
    
    var inText1: String
    var inText2: String
    
    var body: some View {
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
    }
    
}
