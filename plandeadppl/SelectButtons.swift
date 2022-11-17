//
//  SelectButtons.swift
//  plandeadppl
//
//  Created by Hobo on 17/11/2022.
//

import SwiftUI

struct SemSelect: View {
    
    @Binding var sem: String
    
    var body: some View {
        HStack {
            Group {
                Button("Sem 1", action: {sem = "1"})
                .foregroundColor(sem == "1" ? ColorAux1 : ColorAux4)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(sem == "1" ? ColorMain2 : ColorMain4)
                
                Button("Sem 2", action: {sem = "2"})
                .foregroundColor(sem == "2" ? ColorAux1 : ColorAux4)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(sem == "2" ? ColorMain2 : ColorMain4)
                
                Button("Sem S", action: {sem = "S"})
                .foregroundColor(sem == "S" ? ColorAux1 : ColorAux4)
                .padding(.horizontal, 15)
                .padding(.vertical, 8)
                .background(sem == "S" ? ColorMain2 : ColorMain4)
            }
            .cornerRadius(10)
            .font(.title3)
        }
        .padding(.bottom, 5)
        .padding(.top, 5)
    }
    
}


struct WeekdaySelect: View {
    
    @Binding var weekday: String
    
    var body: some View {
        HStack {
            Group {
                Button("Mon", action: {weekday = "1"})
                .foregroundColor(weekday == "1" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "1" ? ColorMain2 : ColorMain4)
                
                Button("Tue", action: {weekday = "2"})
                .foregroundColor(weekday == "2" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "2" ? ColorMain2 : ColorMain4)
                
                Button("Wed", action: {weekday = "3"})
                .foregroundColor(weekday == "3" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "3" ? ColorMain2 : ColorMain4)
                
                Button("Thu", action: {weekday = "4"})
                .foregroundColor(weekday == "4" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "4" ? ColorMain2 : ColorMain4)
                
                Button("Fri", action: {weekday = "5"})
                .foregroundColor(weekday == "5" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "5" ? ColorMain2 : ColorMain4)
                
                Button("Sat", action: {weekday = "6"})
                .foregroundColor(weekday == "6" ? ColorAux1 : ColorAux4)
                .frame(width: 50)
                .padding(.vertical, 8)
                .background(weekday == "6" ? ColorMain2 : ColorMain4)
            }
            .cornerRadius(10)
            .font(.title3)
        }
        .padding(.bottom, 5)
    }
}
