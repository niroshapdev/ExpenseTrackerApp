//
//  ViewCategoriesView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct CategoriesListView: View {
    @ObservedObject private var viewModel = CategoryViewModel()
    @Environment(\.dismiss) private var dismiss
    @Binding private var selectedCategory: Category
    
    init(selectedCategory: Binding<Category>) {
        _selectedCategory = selectedCategory
    }
    
    var body: some View {
        contentView
            .onAppear {
                viewModel.fetchCategories()
            }
    }
    
    private var contentView: some View {
        viewModel.categories.isEmpty
        ? AnyView(errorView)
        : AnyView(listView)
    }
    
    private var errorView: some View {
        Text(viewModel.errorText)
            .padding()
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.categories, id: \.id) { category in
                HStack {
                    Image(systemName: category.icon ?? "")
                    Text(category.title ?? "")
                }
                .onTapGesture {
                    selectedCategory = category
                }
            }
            .onDelete(perform: deleteItem)
        }
    }
    
    private func delete(category: Category) {
        viewModel.delete(category: category)
    }
    
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            viewModel.delete(category: viewModel.categories[index])
        }
    }
}

#Preview {
    let selectedCategory: Category = DefaultConstants.defaultCategory
    return CategoriesListView(selectedCategory: .constant(selectedCategory))
}
