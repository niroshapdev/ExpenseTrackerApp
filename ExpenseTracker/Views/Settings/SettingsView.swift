//
//  SettingsView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct SettingsView: View {
    @State var selectedCategory: Category = DefaultConstants.defaultCategory
    @State var selectedAccount: Account = DefaultConstants.defaultAccount
    
    let chartData = [
        ChartData(amount: 100, color: .green),
        ChartData(amount: 200, color: .blue),
        ChartData(amount: 140, color: .orange),
        ChartData(amount: 260, color: .yellow),
        ChartData(amount: 900, color: .red)
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                contentView
                    .customNavigationView(title: StringConstants.SettingsConstants.screenTitle)
            }
            
        }
    }
    
    private var contentView: some View {
        return List {
            Section {
                NavigationLink(destination: DeveloperModeView()) {
                    Text(StringConstants.SettingsConstants.developerMode)
                }
            }
            
            Section(header: Text(StringConstants.SettingsConstants.views)) {
                NavigationLink(destination: AddCategoryView()) {
                    Text(StringConstants.SettingsConstants.addCategory)
                }
                NavigationLink(destination: CategoriesListView(selectedCategory: $selectedCategory)) {
                    Text(StringConstants.SettingsConstants.viewCategories)
                }
                NavigationLink(destination: AddAccountView()) {
                    Text(StringConstants.AccountConstants.addAccount)
                }
                NavigationLink(destination: AccountsListView()) {
                    Text(StringConstants.AccountConstants.viewAccounts)
                }
                NavigationLink(destination: AddEditTransactionView()) {
                    Text(StringConstants.TransactionConstants.addTransaction)
                }
                NavigationLink(destination: TransactionsListView()) {
                    // ToDo: handle this to display all transactions
                    Text(StringConstants.TransactionConstants.viewTransactions)
                }
                NavigationLink(destination: AddEditGoalView()) {
                    Text(StringConstants.GoalConstants.addGoal)
                }
                NavigationLink(destination: GoalsListView()) {
                    Text(StringConstants.GoalConstants.viewGoals)
                }
            }
            
            Section(header: Text(StringConstants.SettingsConstants.components)) {
                NavigationLink(destination: ProgressView(current: 60, target: 100, style: .circle)) {
                    Text(StringConstants.SettingsConstants.progressView)
                }
                NavigationLink {
                    VStack {
                        ButtonsView(title: "Hello, World!", buttonStyle: .primary, action: { })
                        ButtonsView(title: "Delete", buttonStyle: .destructive, action: { })
                    }
                } label: {
                    Text(StringConstants.SettingsConstants.buttonsView)
                }
                NavigationLink {
                    VStack {
                        FloatingLabelTextField(placeHolder: "Amount", text: .constant(""))
                            .padding()
                        Spacer()
                    }
                } label: {
                    Text(StringConstants.SettingsConstants.floatingTextField)
                }
                NavigationLink {
                    VStack {
                        PieChart(
                            chartData.map { (chartData) in
                                return (chartData.color, Double(chartData.amount))
                            }
                        )
                        .frame(width: 200, height: 200)
                        Spacer()
                    }
                } label: {
                    Text(StringConstants.SettingsConstants.pieChart)
                }
            }
        }
    }
}

private struct AccountsListView: View {
    @ObservedObject var viewModel = AccountsViewModel()
    var body: some View {
        listView
            .onAppear {
                viewModel.fetchAccounts()
            }
    }
    
    var listView: some View {
        List {
            ForEach(viewModel.accounts, id: \.id) { account in
                VStack(alignment: .leading) {
                    Text(account.title ?? "")
                    Text("\(account.balance ?? 0.0)")
                }
            }
            .onDelete(perform: deleteItem)
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            viewModel.delete(account: viewModel.accounts[index])
        }
    }
}

private struct TransactionsListView: View {
    @ObservedObject var viewModel = TransactionViewModel()
    var body: some View {
        listView
            .onAppear {
                viewModel.fetchTransactions()
            }
    }
    
    var listView: some View {
        List(viewModel.transactions, id: \.id) { item in
            VStack(alignment: .leading) {
                HStack {
                    Text(item.category?.title ?? "")
                    Spacer()
                    Text(Utils.dateToString(date: item.date ?? .now))
                }
                Text("\(item.amount ?? 0.0)")
            }
        }
    }
}

#Preview {
    SettingsView()
}
