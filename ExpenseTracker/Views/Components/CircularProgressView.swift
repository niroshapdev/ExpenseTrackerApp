//
//  CircularProgressView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 22/10/23.

import SwiftUI

struct CircularProgressView: View {
    @Binding var completion: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: 0, to: completion)
            .stroke(ColorConstants.purpleColor, lineWidth: 2)
            .overlay(
                Circle()
                    .stroke(Color.gray, lineWidth: 1)
            )
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    CircularProgressView(completion: .constant(40/100))
}
