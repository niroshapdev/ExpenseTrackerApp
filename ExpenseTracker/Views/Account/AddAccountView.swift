//
//  AddAccountView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct AddAccountView: View {
    
    @ObservedObject var viewModel = AccountsViewModel()
    @State var title: String = ""
    @State var balance: String = ""
    @State var notes: String = ""
    @State var currency : String = StringConstants.AppConstants.inrCurrency
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            contentView
            Spacer()
        }
        .customNavigationView(title: StringConstants.AccountConstants.addAccount)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    viewModel.add(account: 
                                    Account(balance: $balance.wrappedValue.toDouble(), 
                                            title: $title.wrappedValue,
                                            currency: Currency(rawValue: $currency.wrappedValue),
                                            notes: $notes.wrappedValue
                                           ))
                    dismiss()
                }, label: {
                    Text(StringConstants.TodayViewConstants.save)
                        .tint(.white)
                        .imageScale(.small)
                })
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            UnderlineTextFieldView(
                text: $title,
                textFieldView: textView,
                placeholder: StringConstants.title)
            .padding(.top, 30)
            
            UnderlineTextFieldView(
                text: $balance,
                textFieldView: balanceView,
                placeholder: StringConstants.AccountConstants.balance)
            .padding(.top, 30)
            
            UnderlineTextFieldView(
                text: $notes,
                textFieldView: notesView,
                placeholder: StringConstants.AccountConstants.notes)
            .padding(.top, 30)
            
            UnderlineTextFieldView(
                text: $currency,
                textFieldView: currencyView,
                placeholder: StringConstants.AccountConstants.currency)
            .padding(.top, 30)
        }
    }
    
}

#Preview {
    AddAccountView()
}

extension AddAccountView {
    private var textView: some View {
        TextField("", text: $title)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
    
    private var balanceView: some View {
        TextField("", text: $balance)
            .foregroundColor(.black)
            .keyboardType(.numberPad)
            .autocapitalization(.none)
    }
    
    private var notesView: some View {
        TextField("", text: $notes)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
    
    private var currencyView: some View {
        TextField("", text: $currency)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
    
}
