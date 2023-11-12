//
//  PieChart.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 05/11/23.
//

import Foundation
import SwiftUI

struct ChartData: Identifiable {
    let id = UUID()
    let amount: Double
    let color: Color
}

struct PieChart: View {
    
    fileprivate var slices: [PieSlice] = []
    
    init(_ values: [(Color, Double)]) {
        slices = calculateSlices(from: values)
    }
    
    var body: some View {
        GeometryReader { reader in
            let halfWidth = (reader.size.width / 2)
            let halfHeight = (reader.size.height / 2)
            let radius =  min(halfWidth, halfHeight)
            let center = CGPoint(x: halfWidth, y: halfHeight)
            ZStack(alignment: .center) {
                ForEach(slices, id: \.self) { slice in
                    Path { path in
                        path.move(to: center)
                        path.addArc(center: center, radius: radius, 
                                    startAngle: slice.start, endAngle: slice.end,
                                    clockwise: false)
                    }
                    .fill(slice.color)
                    
                }
            }
        }
    }
    
    private func calculateSlices(from inputValues: [(color: Color, value: Double)]) -> [PieSlice] {
                
        let sumOfAllValues = inputValues.reduce(0) { $0 + $1.value }
        
        guard sumOfAllValues > 0 else {
            return []
        }
        
        let degreeForOneValue = 360.0 / sumOfAllValues
        var currentStartAngle = 0.0
        
        var slices = [PieSlice]()
        inputValues.forEach { inputValue in
            let endAngle = degreeForOneValue * inputValue.value 
                           + currentStartAngle
            slices.append(PieSlice(start: Angle(degrees: currentStartAngle), 
                                   end: Angle(degrees: endAngle),color: inputValue.color))
            currentStartAngle = endAngle
        }

        return slices
    }
}

private struct PieSlice : Hashable {
    var start: Angle
    var end: Angle
    var color: Color
}
