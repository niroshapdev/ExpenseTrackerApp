//
//  AddCategoryView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject private var viewModel = CategoryViewModel()
    @State private var selectedCategoryType: CategoryType = .income
    @State private var currentCategoryTypeIndex = 0
    @State private var nameText: String = ""
    @State private var iconName: String = IconConstants.plus
    @State private var isIconTapped = false
    @State private var categoryColor = DefaultConstants.defaultColor
    
    @Environment(\.dismiss) private var dismiss
    private var categoryType = CategoryType.allCases
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack {
            HStack {
                iconView
                nameView
                colorPickerView
            }
            categoryTypeView
            Spacer()
        }
        .onAppear {
            viewModel.fetchCategories()
        }
        .customNavigationView(title: StringConstants.TodayViewConstants.newCategory)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.add(title: $nameText.wrappedValue,
                                  color: categoryColor.toString(), icon: iconName,
                                  type: selectedCategoryType)
                    dismiss()
                } label: {
                    Text(StringConstants.TodayViewConstants.save)
                        .tint(.white)
                        .imageScale(.small)
                }
            }
        }
        .sheet(isPresented: $isIconTapped) {
            sfSymbolsView
        }
    }
    
    private var iconView: some View {
        ZStack {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .foregroundStyle(categoryColor)
        }
        .onTapGesture {
            isIconTapped.toggle()
        }
    }
    
    private var nameView: some View {
        FloatingLabelTextField(placeHolder: StringConstants.title, text: $nameText)
    }
    
    private var sfSymbolsView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
            ForEach(StringConstants.AppConstants.categoryIcons, id: \.self) { iconTitle in
                SymbolImage(imageName: iconTitle)
                    .onTapGesture {
                        iconName = iconTitle
                        isIconTapped.toggle()
                    }
            }
        }
    }
    private var colorPickerView: some View {
        ZStack {
            ColorPicker("", selection: $categoryColor)
                .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: 0))
                .frame(width: 40, height: 40)
        }
    }
    
    private var categoryTypeView: some View {
        VStack {
            HStack {
                Text(StringConstants.TodayViewConstants.categoryType)
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundStyle(ColorConstants.purpleColor)
                    .padding(.leading, 12)
                Spacer()
                FilterButtonView(text: selectedCategoryType.rawValue)
                    .onTapGesture {
                        self.currentCategoryTypeIndex = (self.currentCategoryTypeIndex + 1) % categoryType.count
                        selectedCategoryType = categoryType[currentCategoryTypeIndex]
                    }
            }
            SeparatorView()
        }
        .padding(.top, 16)
    }
}

struct SymbolImage: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .foregroundStyle(.black)
    }
}
#Preview {
    AddCategoryView()
}
