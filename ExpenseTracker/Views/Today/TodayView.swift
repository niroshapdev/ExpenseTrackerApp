//
//  TodayView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI

struct TodayView: View {
    @ObservedObject var viewModel = TodayViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                headerView
                SeparatorView()
                ScrollView {
                    contentTopView
                    contentBottomView
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
    
    private var headerView: some View {
        HStack {
            navigationTitle
            Spacer()
            NavigationLink(destination: AddEditTransactionView()) {
                Icons.plusImage
            }
        }
    }
    
    private var navigationTitle: some View {
        DateHeaderView(day: "\(Utils.getDay())", 
                       dayName: "\(Utils.getDayName())",
                       month: "\(Utils.getMonth())",
                       year: "\(Utils.getYear())")
    }
    
    private var contentTopView: some View {
        GoalsView(goals: viewModel.goals)
            .padding(.top, 10)
    }
    
    private var contentBottomView: some View {
        TransactionsView(transactions: viewModel.transactions)
            .padding(.top, 10)
    }
    
}

#Preview {
    return TodayView()
}
