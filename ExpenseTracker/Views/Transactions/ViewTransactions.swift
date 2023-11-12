//
//  ViewTransactions.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI
public enum TransactionFilter: String, CaseIterable {
    case last7days = "Last 7 days"
    case last30days = "Last 30 days"
    case last90days = "Last 90 days"
    case thisMonth = "This Month"
    case lastMonth = "Last Month"
    case thisYear = "This Year"
    case lastYear = "Last Year"
}

struct ViewTransactions: View {
    @ObservedObject var viewModel = TransactionViewModel()
    @State private var selectedFilter: TransactionFilter = .last30days
    @State private var fromDate: Date?
    @State private var toDate: Date?
    @State private var isDoneButtonTappedFromDate = false
    @State private var isDoneButtonTappedToDate = false
    
    private var selectedAccount: Account
    private var isSelectAccount: Bool
    
    // Default values
    init(account: Account) {
        self.isSelectAccount = true
        selectedAccount = account
    }
    
    var body: some View {
        contentView
            .onAppear {
                if(isSelectAccount) {
                    viewModel.fetchTransactions(for: selectedAccount)
                } else {
                    viewModel.fetchTransactions()
                }
            }
            .customNavigationView(title: StringConstants.TransactionConstants.viewTransactions)
    }
    
    private var contentView: some View {
        viewModel.transactions.isEmpty
        ? AnyView(errorView)
        : AnyView(
            ScrollView {
                filterView
                VStack {
                    listView
                    balanceView
                }
            })
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
                        self.viewModel.filterTransactionsByCustomDate(
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
                        self.viewModel.filterTransactionsByCustomDate(
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
    
    private var errorView: some View {
        Text(StringConstants.TransactionConstants.noTransactions)
            .padding()
    }
    private var listView: some View {
        VStack {
            ForEach(viewModel.transactions,
                    id: \.id) { transaction in
                VStack {
                    HStack(alignment: .top) {
                        transactionDetailView(for: transaction)
                        Spacer()
                        transactionAmountView(for: transaction)
                    }
                    SeparatorView()
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var balanceView: some View {
        HStack {
            Text(StringConstants.AccountConstants.openingBalance)
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
            Text(String(selectedAccount.balance ?? 0.0))
                .font(.body)
                .fontWeight(.semibold)
                .padding(.horizontal)
        }
    }
    private func transactionDetailView(for transaction: Transaction) -> some View {
        HStack {
            Image(systemName: viewModel.getCategoryIcon(transaction: transaction))
                .resizable()
                .frame(width: 25, height: 25)
            VStack(alignment: .leading) {
                Text(viewModel.getCategoryTitle(transaction: transaction))
                    .font(.body)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(Utils.dateToString(date: transaction.date ?? Utils.formatDate(date: .now)))
                    .font(.body)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private func transactionAmountView(for transaction: Transaction) -> some View {
        VStack(alignment: .trailing) {
            Utils.getFormattedAmount(transactionType: transaction.type ?? .debit, amount: transaction.amount ?? 0.0)
            Text(transaction.updatedBalance ?? "")
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
}
