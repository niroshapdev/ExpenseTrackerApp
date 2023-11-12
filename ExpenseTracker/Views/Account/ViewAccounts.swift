//
//  ViewAccounts.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 22/10/23.
//

import SwiftUI

struct ViewAccounts: View {
    
    @ObservedObject var viewModel = AccountsViewModel()
    @Environment(\.dismiss) private var dismiss
    var onSelect: (_ account: Account) -> Void
    @State private var isRowTapped: Bool = false
    @State private var selectedAccount: Account?
    @State private var isEditTapped: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                headerView
                contentView
                footerView
            }
            .onAppear {
                viewModel.fetchAccounts()
                for account in viewModel.accounts {
                    viewModel.getUpdatedBalance(for: account)
                }
            }
            .customNavigationView(title: StringConstants.AccountConstants.accounts)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: AddAccountView()) {
                        Text(StringConstants.AccountConstants.add)
                    }
                }
            }
            .navigationDestination(isPresented: $isRowTapped) {
                ViewTransactions(account: selectedAccount ?? DefaultConstants.defaultAccount)
            }
        }
    }
    
    private var contentView: some View {
        viewModel.accounts.isEmpty
        ? AnyView(errorView)
        : AnyView(accountsListView)
    }
    
    private var headerView: some View {
        VStack(alignment: .leading) {
            Text(StringConstants.AccountConstants.paymentAccounts)
                .foregroundColor(.black)
                .font(.headline)
                .fontWeight(.bold)
            SeparatorView()
        }
    }
    
    private var errorView: some View {
        Text(viewModel.errorText)
            .padding()
    }

    private var accountsListView: some View {
        ForEach(viewModel.accounts.indices, id: \.self) { index in
            let account = viewModel.accounts[index]
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: IconConstants.menucard)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(ColorConstants.purpleColor)
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                    viewTransactions(for: account, atIndex: index)
                }
                SeparatorView()
            }
            .onTapGesture {
                dismiss()
                selectedAccount = account
                onSelect(account)
                isRowTapped.toggle()
            }
        }
    }
    
    private func viewTransactions(for account: Account, atIndex index: Int) -> some View {
        VStack(alignment: .leading) {
            Text(account.title ?? "")
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if index < viewModel.balances.count {
                let balance = String(viewModel.balances[account.title ?? ""] ?? 0.0)
                Text(balance)
                    .font(.body)
                    .fontWeight(.regular)
            }
        }
        .onAppear {
            viewModel.getUpdatedBalance(for: account)
        }
    }
    
    private var footerView: some View {
        HStack {
            Text(StringConstants.AccountConstants.totalBalance)
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
            Text(String(viewModel.totalBalance))
                .font(.body)
                .fontWeight(.semibold)
                .padding(.horizontal)
        }
    }
}
