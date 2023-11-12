//
//  AddTransactionView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation
import SwiftUI

/*
 // =============================== //
 Transaction Type   > Income / Expense
 Select Account     > Accounts list
 Select Category    > Categories List (Income / Expense)
 Amount
 Select Date
 Payment Status     > Paid / Overdue
 Add Notes
 // =============================== //
 */

struct AddEditTransactionView: View {
    @ObservedObject private var viewModel = TransactionViewModel()
    @State private var accountTitle: String =
    StringConstants.TransactionConstants.selectAccount
    
    @State private var isAccountTapped = false
    @State private var isCategoryTapped = false
    @State private var dateTapped: Bool = false
    @State private var currentPaymentStatusIndex = 0
    @State var selectedAccount: Account = DefaultConstants.defaultAccount
    @State var selectedCategory: Category = DefaultConstants.defaultCategory
    @State private var categoryTitle: String = ""
    private var isEditTransaction = false
    // Payment
    private var paymentStatus = PaymentStatus.allCases
    @State private var selectedPaymentStatus: PaymentStatus = .paid
    
    private var transactionType = TransactionType.allCases
    @State private var selectedTransactionType: TransactionType = .debit
    @State private var amount: String = ""
    @State private var date = Date()
    @State private var notes: String = ""
    // current selected transaction for edit / delete transaction
    private var selectedTransaction: Transaction?
    @Environment(\.dismiss) private var dismiss
    
    init(type: TransactionType, account: Account,
         category: Category,
         amount: Double,
         date: Date,
         status: PaymentStatus,
         notes: String) {
        isEditTransaction = false
        self.selectedTransactionType = type
        self.selectedAccount = account
        self.selectedCategory = category
        self.amount = amount.toString()
        self.date = date
        self.selectedPaymentStatus = status
        self.notes = notes
    }
    
    // initializer with default values
    init(transaction: Transaction) {
        isEditTransaction = true
        selectedTransaction = transaction
        _selectedTransactionType =  State(initialValue: transaction.type ?? .credit)
        _selectedAccount = State(initialValue: transaction.account ??
                                 DefaultConstants.defaultAccount)
        _selectedCategory = State(initialValue: transaction.category ??
                                  DefaultConstants.defaultCategory)
        _amount = State(initialValue: transaction.amount?.toString() ?? "")
        _date = State(initialValue: transaction.date ?? Utils.formatDate(date: .now))
        _selectedPaymentStatus = State(initialValue: transaction.status ?? .paid)
        _notes = State(initialValue: transaction.notes ?? "")
    }
    
    init() {}
    
    var body: some View {
        NavigationStack {
            VStack {
                contentView
                Spacer()
            }
            .customNavigationView(title:
                                    isEditTransaction
                                  ? StringConstants.TransactionConstants.editTransaction
                                  : StringConstants.TransactionConstants.addTransaction)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if(isEditTransaction) {
                            viewModel.edit(
                                transaction: Transaction(id: selectedTransaction?.id ?? UUID(),
                                                         type: selectedTransactionType,
                                                         account: $selectedAccount.wrappedValue,
                                                         category: $selectedCategory.wrappedValue,
                                                         amount: $amount.wrappedValue.toDouble() ?? 0.0,
                                                         date: $date.wrappedValue,
                                                         status: selectedPaymentStatus,
                                                         notes: $notes.wrappedValue))
                        } else {
                            viewModel.add(type: selectedTransactionType,
                                          account: $selectedAccount.wrappedValue,
                                          category: $selectedCategory.wrappedValue,
                                          amount: $amount.wrappedValue.toDouble() ?? 0.0,
                                          date: $date.wrappedValue,
                                          paymentStatus: selectedPaymentStatus,
                                          notes: $notes.wrappedValue,
                                          updatedBalance:
                                            BalanceManager.getUpdatedBalance(
                                                amount:
                                                    $amount.wrappedValue.toDouble() ?? 0.0,
                                                accountTitle:
                                                    $selectedAccount.wrappedValue.title ?? "",
                                                accountBalance:
                                                    $selectedAccount.wrappedValue.balance ?? 0.0,
                                                type: selectedTransactionType)
                            )
                        }
                        dismiss()
                        
                    }, label: {
                        Text("Save")
                            .tint(.white)
                            .imageScale(.small)
                    })
                }
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            categoryView
            accountView
            amountView
            transactionTypeView
            notesView
            
            HStack {
                dateView
                Spacer()
                paymentStatusView
            }
            .padding()
            
            if let transaction = selectedTransaction, isEditTransaction {
                ButtonsView(title: "Delete", buttonStyle: .destructive) {
                    viewModel.delete(transaction: transaction)
                    dismiss()
                }
                .padding(.top, 50)
            }
            
        }
        .sheet(isPresented: $isAccountTapped) {
            ViewAccounts { account in
                accountTitle = account.title ?? ""
                selectedAccount = account
            }
        }
        
        .sheet(isPresented: $isCategoryTapped) {
            ChooseCategoryView(selectedCategory: $selectedCategory)
        }
        
        .sheet(isPresented: $dateTapped, content: {
            DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorMultiply(.black)
        })
    }
    
    @State private var currentTransactionTypeIndex = 0
    private var transactionTypeView: some View {
        VStack {
            HStack {
                Text(StringConstants.TransactionConstants.transactionType)
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(ColorConstants.purpleColor)
                    .padding(.leading, 12)
                Spacer()
                FilterButtonView(text: selectedTransactionType.rawValue)
                    .onTapGesture {
                        self.currentTransactionTypeIndex =
                        (self.currentTransactionTypeIndex + 1) % transactionType.count
                        selectedTransactionType = transactionType[currentTransactionTypeIndex]
                    }
            }
            SeparatorView()
        }
        .padding(.top, 16)
    }
    
    private var accountView: some View {
        guard let title = $selectedAccount.wrappedValue.title else {
            return AnyView(EmptyView())
        }
        return AnyView(
            ButtonsView(
                title: title.isEmpty
                ? StringConstants.TransactionConstants.selectAccount
                : title,
                buttonStyle: .custom,
                action: {
                    isAccountTapped.toggle()
                }
            )
        )
    }
    
    private var categoryView: some View {
        guard let title = $selectedCategory.wrappedValue.title else {
            return AnyView(EmptyView())
        }
        return AnyView(
            ButtonsView(
                title: title.isEmpty
                ? StringConstants.TransactionConstants.selectCategory
                : title,
                buttonStyle: .custom,
                action: {
                    isCategoryTapped.toggle()
                }
            )
        )
    }
    
    private var amountView: some View {
        UnderlineTextFieldView(
            text: $amount,
            textFieldView: textView,
            placeholder: StringConstants.TransactionConstants.amount)
        .padding(.top, 16)
    }
    
    private var dateView: some View {
        Text(Utils.dateToStringWithTime(date: $date.wrappedValue))
            .onTapGesture {
                dateTapped.toggle()
            }
    }
    
    private var paymentStatusView: some View {
        FilterButtonView(text: selectedPaymentStatus.rawValue)
            .onTapGesture {
                self.currentPaymentStatusIndex = (self.currentPaymentStatusIndex + 1) % paymentStatus.count
                selectedPaymentStatus = paymentStatus[currentPaymentStatusIndex]
            }
    }
    
    private var notesView: some View {
        UnderlineTextFieldView(
            text: $notes,
            textFieldView: notesTextView,
            placeholder: StringConstants.TransactionConstants.notes)
        .padding(.top, 16)
    }
}

#Preview {
    return AddEditTransactionView()
}

extension AddEditTransactionView {
    private var textView: some View {
        TextField("", text: $amount)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
    
    private var notesTextView: some View {
        TextField("", text: $notes)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
}
