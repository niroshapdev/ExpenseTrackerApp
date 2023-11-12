//
//  SegmentedControl.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 31/10/23.
//

import SwiftUI

struct SegmentedControl: View {
    var segments: [String]
    @Binding var selectedSegment: Int
    
    var body: some View {
        Picker(selection: $selectedSegment, label: Text("")) {
            ForEach(0..<segments.count, id: \.self) { index in
                Text(segments[index]).tag(index)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}

struct CategoryPicker: View {
    @Binding var selectedCategory: CategoryType
    
    var body: some View {
        Picker("Select Category", selection: $selectedCategory) {
            ForEach(CategoryType.allCases, id: \.self) { category in
                Text(category.rawValue.capitalized).tag(category)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
