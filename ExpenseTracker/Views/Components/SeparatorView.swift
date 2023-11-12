//
//  SeparatorView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 22/10/23.
//

import SwiftUI

struct SeparatorView: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(ColorConstants.purpleColor)
    }
}

#Preview {
    SeparatorView()
}
