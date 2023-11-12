//
//  AddGoalView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct AddEditGoalView: View {
    
    @ObservedObject var viewModel = GoalsViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var isAccountTapped = false
    
    @State var title: String = ""
    @State var targetAmount: String = ""
    @State var savedAmount: String = ""
    @State var currency : String = StringConstants.AppConstants.inrCurrency
    
    private var isEditGoal = false
    // current selected goal for edit / delete goal
    private var selectedGoal: Goal?
    
    init(title: String, targetAmount: String, savedAmount: String, currency: String) {
        isEditGoal = false
        self.title = title
        self.targetAmount = targetAmount
        self.savedAmount = savedAmount
        self.currency = currency
    }
    
    // initializer with default values
    init(goal: Goal) {
        isEditGoal = true
        selectedGoal = goal
        _title = State(initialValue: goal.title ?? "")
        _targetAmount = State(initialValue: goal.targetAmount?.toString() ?? "")
        _savedAmount = State(initialValue: goal.savedAmount?.toString() ?? "")
        _currency = State(initialValue: goal.currency ?? StringConstants.AppConstants.inrCurrency)
    }
    
    init() { }
    
    var body: some View {
        VStack {
            contentView
            Spacer()
        }
        .customNavigationView(title:  
                                isEditGoal
                              ? StringConstants.GoalConstants.editGoal
                              : StringConstants.GoalConstants.addGoal)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if(isEditGoal) {
                        viewModel.edit(goal: Goal(
                            id: selectedGoal?.id ?? UUID(),
                            title: $title.wrappedValue,
                            targetAmount: $targetAmount.wrappedValue.toDouble(),
                            savedAmount: $savedAmount.wrappedValue.toDouble(),
                            currency: $currency.wrappedValue)
                        )
                    } else { viewModel.add(goal:
                                            Goal(title: $title.wrappedValue,
                                                 targetAmount: $targetAmount.wrappedValue.toDouble(),
                                                 savedAmount: $savedAmount.wrappedValue.toDouble(),
                                                 currency: $currency.wrappedValue)) }
                    dismiss()
                }, label: {
                    Text("Save")
                        .tint(.white)
                        .imageScale(.small)
                })
            }
        }
    }
    
    private var contentView: some View {
        VStack {
            HStack(alignment: .bottom) {
                Icons.goalImage
                    .padding(.bottom, 10)
                FloatingLabelTextField(placeHolder: StringConstants.GoalConstants.enterGoal, text: $title)
                    .padding(.top, 30)
            }
            
            UnderlineTextFieldView(
                text: $targetAmount,
                textFieldView: targetAmountView,
                placeholder: StringConstants.GoalConstants.targetAmount)
            .padding(.top, 30)
            
            UnderlineTextFieldView(
                text: $savedAmount,
                textFieldView: savedAmountView,
                placeholder: StringConstants.GoalConstants.savedAmount)
            .padding(.top, 30)
            .onTapGesture {
                isAccountTapped.toggle()
            }
            .sheet(isPresented: $isAccountTapped) {
                ViewAccounts { account in
                    savedAmount = account.balance?.toString() ?? " "
                }
            }
            UnderlineTextFieldView(
                text: $currency,
                textFieldView: currencyView,
                placeholder: StringConstants.AccountConstants.currency)
            .padding(.top, 30)
            
            if let goal = selectedGoal, isEditGoal {
                ButtonsView(title: "Delete", buttonStyle: .destructive) {
                    viewModel.delete(goal: goal)
                    dismiss()
                }
                .padding(.top, 50)
            }
        }
    }
}

#Preview {
    AddEditGoalView()
}

extension AddEditGoalView {
    private var textView: some View {
        TextField("", text: $title)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
    
    private var targetAmountView: some View {
        TextField("", text: $targetAmount)
            .foregroundColor(.black)
            .keyboardType(.numberPad)
            .autocapitalization(.none)
    }
    
    private var savedAmountView: some View {
        TextField("", text: $savedAmount)
            .foregroundColor(.black)
            .keyboardType(.numberPad)
            .autocapitalization(.none)
    }
    
    private var currencyView: some View {
        TextField("", text: $currency)
            .foregroundColor(.black)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
    }
}
