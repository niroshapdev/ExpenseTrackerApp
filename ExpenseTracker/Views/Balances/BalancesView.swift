//
//  BalancesView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI

struct BalancesView: View {
    
    @ObservedObject var viewModel = AccountsViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        contentView
            .customNavigationView(title: StringConstants.BalancesConstants.balancesTab)
    }
    
    private var contentView: some View {
        viewModel.hasError
        ? AnyView(errorView)
        : AnyView(viewAccountsList)
    }
    
    private var errorView: some View {
        Text(StringConstants.BalancesConstants.errorText)
            .padding()
    }
    
    private var viewAccountsList: some View {
        ViewAccounts(onSelect: { _ in })
    }
}

#Preview {
    BalancesView()
}
