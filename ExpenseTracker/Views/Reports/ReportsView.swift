//
//  ReportsView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 27/10/23.
//

import SwiftUI

struct ReportsView: View {
    @ObservedObject var viewModel = ReportsViewModel()
    @State private var selectedCategory = CategoryType.income
    private let segments = [StringConstants.ReportsConstants.income, StringConstants.ReportsConstants.expenses]
    
    @State private var selectedFilter: TransactionFilter = .last30days
    @State private var fromDate: Date?
    @State private var toDate: Date?
    @State private var isDoneButtonTappedFromDate = false
    @State private var isDoneButtonTappedToDate = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentView
            }
            .onAppear {
                viewModel.getTransactions()
            }
            .customNavigationView(title: StringConstants.ReportsConstants.reports)
        }
    }
    
    private var contentView: some View {
        viewModel.transactions.isEmpty ? AnyView(errorView) : AnyView(segmentView)
    }
    
    private var filterView: some View {
        VStack {
            HStack {
                DatePickerTextField(
                    isDoneButtonTapped: $isDoneButtonTappedFromDate,
                    placeholder: "From Date",
                    date: $fromDate)
                .onChange(of: fromDate) { newValue in
                    if (newValue != nil) {
                        self.viewModel.getTransactions(
                            fromDate: $fromDate.wrappedValue ?? Date(),
                            toDate: $toDate.wrappedValue ?? Date()
                        )
                    }
                }
                
                DatePickerTextField(
                    isDoneButtonTapped: $isDoneButtonTappedToDate,
                    placeholder: "To Date",
                    date: $toDate)
                .onChange(of: toDate) { newValue in
                    if (newValue != nil) {
                        self.viewModel.getTransactions(
                            fromDate: $fromDate.wrappedValue ?? Date(),
                            toDate: $toDate.wrappedValue ?? Date()
                        )
                    }
                }
                
                Menu {
                    ForEach(TransactionFilter.allCases, id: \.self) { filter in
                        Button {
                            selectedFilter = filter
                            viewModel.filterTransactions(for: selectedFilter)
                        } label: {
                            Text(filter.rawValue)
                        }
                    }
                } label: {
                    Image(systemName: IconConstants.filter)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding()
            .foregroundStyle(.black)
        }
    }
    
    @ViewBuilder
    private var segmentView: some View {
        VStack {
            filterView
            CategoryPicker(selectedCategory: $selectedCategory)
        }
        VStack {
            totalExpensesView
            if(selectedCategory == .income) {
                incomeChartView
            } else {
                expenseChartView
            }
            categoryListView
        }
    }
    
    private var errorView: some View {
        Text(StringConstants.ReportsConstants.errorText)
            .padding()
    }
    
    private var totalExpensesView: some View {
        VStack {
            Text(selectedCategory == .income ?
                 StringConstants.ReportsConstants.totalIncome : 
                    StringConstants.ReportsConstants.totalExpenses)
            .foregroundColor(.black)
            .font(.system(size: 24))
            .font(.headline)
            .fontWeight(.bold)
            Spacer()
            Text(selectedCategory == .income 
                 ? viewModel.getTotalIncome().toString()
                 : viewModel.getTotalExpenses().toString())
            .foregroundColor(.black)
            .font(.system(size: 22))
            .fontWeight(.semibold)
        }
    }
    
    private var categoryListView: some View {
        VStack {
            if (selectedCategory == .income) {
                ForEach(viewModel.incomeTransactions, id: \.id) { transaction in
                    transactionRowView(for: transaction)
                }
            } else {
                ForEach(viewModel.expenseTransactions, id: \.id) { transaction in
                    transactionRowView(for: transaction)
                }
            }
        }
    }
    
    private func transactionRowView(for transaction: Transaction) -> some View {
        VStack {
            HStack {
                Image(systemName: viewModel.getCategoryIcon(transaction: transaction))
                    .resizable()
                    .foregroundColor(Utils.colorFromHex(transaction.category?.color ?? DefaultConstants.colorString))
                    .frame(width: 25, height: 25)
                Text(viewModel.getCategoryTitle(transaction: transaction))
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.regular)
                Spacer()
                Text(transaction.amount?.toString() ?? "")
                    .foregroundColor(.black)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            SeparatorView()
        }
    }
    
    private var incomeChartView: some View {
        let data = viewModel.incomeChartData
        let transformedData: [(Color, Double)] = data.map { (chartData) in
            return (chartData.color, Double(chartData.amount))
        }
        return  PieChart(transformedData)
            .frame(width: 200, height: 200)
    }
    
    private var expenseChartView: some View {
        let data = viewModel.expenseChartData
        let transformedData: [(Color, Double)] = data.map { (chartData) in
            return (chartData.color, Double(chartData.amount))
        }
        return  PieChart(transformedData)
            .frame(width: 200, height: 200)
    }
}

#Preview {
    ReportsView()
}
