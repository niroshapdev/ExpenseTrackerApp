//
//  ProgressView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 22/10/23.
//

import SwiftUI

enum ProgressViewStyle {
    case circle
}

struct ProgressView: View {
    private var current: CGFloat
    private var target: CGFloat
    private var style: ProgressViewStyle
    
    public init(current: CGFloat, target: CGFloat, style: ProgressViewStyle = .circle) {
        self.current = current
        self.target = target
        self.style = style
    }
    
    private var completion: CGFloat {
        current / target
    }
    
    var body: some View {
        switch style {
        case .circle:
            CircularProgressView(completion: .constant(completion))
        }
    }
}

#Preview {
    ProgressView(current: 40, target: 100, style: .circle)
}
     
