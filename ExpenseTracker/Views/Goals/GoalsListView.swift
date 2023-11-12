//
//  GoalsListView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 20/10/23.
//

import SwiftUI

struct GoalsListView: View {
    @ObservedObject var viewModel = GoalsViewModel()
    @State private var isRowTapped: Bool = false
    @State private var selectedGoal: Goal?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        listView
            .onAppear {
                viewModel.fetchGoals()
            }
            .navigationDestination(isPresented: $isRowTapped) {
                AddEditGoalView(goal: $selectedGoal.wrappedValue ?? Goal())
            }
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.goals, id: \.id) { goal in
                HStack(alignment: .top) {
                    Text(goal.title ?? "")
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("\(goal.savedAmount ?? 0.0)")
                        Text("\(goal.targetAmount ?? 0.0)")
                    }
                }
                .onTapGesture {
                    self.selectedGoal = goal
                    isRowTapped.toggle()
                }
            }
        }
    }
}
