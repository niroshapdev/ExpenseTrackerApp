//
//  ChooseCategoryView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct ChooseCategoryView: View {
    @Binding private var selectedCategory: Category
    init(selectedCategory: Binding<Category>) {
        _selectedCategory = selectedCategory
    }
    @ObservedObject var viewModel = CategoryViewModel()
    @State private var selectedCategoryType = CategoryType.income
    @State private var isIconTapped = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
                contentView
                .onAppear {
                    viewModel.fetchCategories()
                }
                .customNavigationView(title: StringConstants.TodayViewConstants.selectIcon)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: AddCategoryView()) {
                            Text(StringConstants.GoalConstants.add)
                        }
                    }
                }
        }
    }
    
    private var contentView: some View {
        viewModel.categories.isEmpty ? AnyView(errorView) : AnyView(gridView)
    }
    
    private var gridView: some View {
        ScrollView {
            CategoryPicker(selectedCategory: $selectedCategoryType)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                
                if selectedCategoryType == .income {
                    ForEach(viewModel.incomeCategories, id: \.self) { category in
                        categoryRowView(for: category, categoryType: .income)
                    }
                } else {
                    ForEach(viewModel.expenseCategories, id: \.self) { category in
                        categoryRowView(for: category, categoryType: .expense)
                    }
                }
                Spacer()
            }
            .padding(16)
        }
    }
    
    private func categoryRowView(for category: Category, categoryType: CategoryType) -> some View {
        VStack {
            Image(systemName: category.icon ?? IconConstants.menucard)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .foregroundStyle(.black)
            Text(category.title ?? "Test")
                .foregroundStyle(.black)
        }
        .onTapGesture {
            isIconTapped.toggle()
            selectedCategory = Category(title: category.title,
                                        color: category.color,
                                        icon: category.icon,
                                        type: .income,
                                        date: category.date ?? Utils.formatDate(date: .now)
            )
            dismiss()
        }
        .contextMenu {
            Button {
                viewModel.delete(category: category)
            } label: {
                Label(StringConstants.CategoryConstants.delete, systemImage: IconConstants.trash)
            }
        }
    }
    
    private var errorView: some View {
        Text(viewModel.errorText)
            .padding()
    }
}
