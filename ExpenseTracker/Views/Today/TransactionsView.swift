//
//  TransactionsView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 24/10/23.
//

import SwiftUI

struct TransactionsView: View {
    var transactions: Transactions
    @ObservedObject var viewModel = TransactionViewModel()

    @State private var isRowTapped: Bool = false
    @State private var selectedTransaction: Transaction?
    
    var plannedTransactions: Transactions {
        // Transactions filtered based on the planned type
        return transactions.filter { $0.status == .planned || $0.status == .overdue }
    }
    
    var paidTransactions: Transactions {
        // Transactions filtered based on the paid type
        return transactions.filter { $0.status == .paid }
    }
    
    var body: some View {
        VStack {
            AnyView(transactionListView)
        }
        .navigationDestination(isPresented: $isRowTapped) {
            AddEditTransactionView(transaction: $selectedTransaction.wrappedValue ??
                                   Transaction(account: DefaultConstants.defaultAccount,
                                               category: DefaultConstants.defaultCategory))
        }
    }
    
    private var transactionListView: some View {
        VStack {
            if (!plannedTransactions.isEmpty) {
                transactionSectionView(
                    title: StringConstants.TransactionConstants.plannedTransactions, 
                    transactions: plannedTransactions)
            }
            if (!paidTransactions.isEmpty) {
                transactionSectionView(
                    title: StringConstants.TransactionConstants.paidTransactions,
                    transactions: paidTransactions)
            }
        }
    }
    
    private func transactionSectionView(title: String, transactions: Transactions) -> some View {
        Section(header: SectionHeaderView(title: title)) {
            ForEach(transactions, id: \.id) { transaction in
                transactionRowView(for: transaction)
            }
        }
    }
    
    private func transactionRowView(for transaction: Transaction) -> some View {
        VStack {
            HStack(alignment: .top) {
                getTransactionIcon(for: transaction)
                Spacer()
                transactionDetailView(for: transaction)
                Spacer()
                transactionAmountView(for: transaction)
            }
            SeparatorView()
        }
        .padding(.horizontal)
        .onTapGesture {
            selectedTransaction = transaction
            isRowTapped.toggle()
        }
    }
    
    private func getTransactionIcon(for transaction: Transaction) -> some View {
        Image(systemName: viewModel.getCategoryIcon(transaction: transaction))
            .resizable()
            .frame(width: 25, height: 25)
            .padding()
    }
    
    private func transactionDetailView(for transaction: Transaction) -> some View {
        VStack(alignment: .leading) {
            Text(viewModel.getCategoryTitle(transaction: transaction))
                .font(.body)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
            
            Text(Utils.dateToString(date: transaction.date ?? Utils.formatDate(date: .now)))
                .font(.body)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
        }
    }
    
    private func transactionAmountView(for transaction: Transaction) -> some View {
        VStack(alignment: .trailing) {
            Utils.getFormattedAmount(transactionType: transaction.type ?? .debit, amount: transaction.amount ?? 0.0)
        }.padding(.top, 10)
    }
}

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(.black)
                .font(.headline)
                .padding(.horizontal, 15)
            Spacer()
            SeparatorView()
                .padding(.horizontal, 15)
        }
    }
}
