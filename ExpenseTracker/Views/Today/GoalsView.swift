//
//  GoalsView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 22/10/23.
//

import SwiftUI

struct GoalsView: View {
    var goals: Goals
    
    @State private var isRowTapped: Bool = false
    @State private var selectedGoal: Goal?
    
    var body: some View {
        VStack {
            headerView
            if (goals.count > 0) {
                AnyView(goalListView)
            } else {
                AnyView(noGoalsView)
            }
        }
        .navigationDestination(isPresented: $isRowTapped) {
            AddEditGoalView(goal: $selectedGoal.wrappedValue ?? Goal())
        }
    }
    
    private var headerView: some View {
        VStack {
            HStack {
                Text(StringConstants.GoalConstants.goals)
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                NavigationLink(destination: AddEditGoalView()) {
                    Text(StringConstants.GoalConstants.add)
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 15)
                        .padding([.top, .bottom], 5)
                        .background(ColorConstants.purpleColor)
                        .cornerRadius(10)
                }
            }
            SeparatorView()
        }
        .padding(.horizontal, 15)
    }
    
    private var goalListView: some View {
        VStack {
            ForEach(goals, id: \.id) { goal in
                VStack {
                    HStack(alignment: .top) {
                        getGoalProgressView(for: goal)
                        Spacer()
                        goalDetailView(for: goal)
                        Spacer()
                        goalAmountView(for: goal)
                    }
                    SeparatorView()
                }
                .padding(.horizontal)
                .onTapGesture {
                    selectedGoal = goal
                    isRowTapped.toggle()
                }
            }
        }
    }
    
    private var noGoalsView: some View {
        VStack {
            HStack {
                Icons.goalImage
                Text(StringConstants.GoalConstants.goalText)
                    .fontWeight(.regular)
                    .font(.callout)
            }
            .padding(.horizontal)
        }
    }
    
    private func getGoalProgressView(for goal: Goal) -> some View {
        ZStack(alignment: .center) {
            ProgressView(current: goal.savedAmount ?? 0.0, target: goal.targetAmount ?? 0.0)
                .frame(width: 40, height: 40)
            Image(systemName: IconConstants.goal)
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
    
    private func goalDetailView(for goal: Goal) -> some View {
        VStack(alignment: .leading) {
            Text(goal.title ?? "")
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            Text(Utils.dateToString(date: Date()))
        }
    }
    
    private func goalAmountView(for goal: Goal) -> some View {
        VStack(alignment: .trailing) {
            let savedAmount = String(goal.savedAmount ?? 0.0)
            Text(savedAmount)
                .foregroundStyle(ColorConstants.purpleColor)
                .fontWeight(.semibold)
                .font(.system(size: 18))
            
            let targetAmount = String(goal.targetAmount ?? 0.0)
            Text(targetAmount)
        }
    }
}

#Preview {
    return GoalsView(goals: TestData.goals)
}
