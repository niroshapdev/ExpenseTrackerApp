//
//  FilterButtonView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 08/11/23.
//

import Foundation
import SwiftUI

struct FilterButtonView: View {
    var text: String
    var image: String = "\u{2193}"
    
    var body: some View {
        Text("\(text) \(image)")
            .foregroundColor(ColorConstants.purpleColor)
            .frame(alignment: .trailing)
            .font(.callout)
            .fontWeight(.semibold)
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(ColorConstants.purpleColor, lineWidth: 1)
            )
    }
}
