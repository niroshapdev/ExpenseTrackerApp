//
//  DateHeaderView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 01/11/23.
//

import SwiftUI

struct DateHeaderView: View {
    var day: String
    var dayName: String
    var month: String
    var year: String

    var body: some View {
        HStack {
            Text(day)
                .fontWeight(.bold)
                .font(.system(size: 50))
            Rectangle()
                .fill(Color.black)
                .frame(width: 2, height: 60)
            VStack(alignment: .leading) {
                Text(dayName)
                    .fontWeight(.bold)
                    .font(.system(size: 25))
                HStack {
                    Text(month)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Text(year)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                }
            }
        }
        .padding()
    }
}
