//
//  ButtonsView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 23/10/23.
//

import SwiftUI

enum ButtonViewStyle {
    case primary, destructive, custom
}

struct ButtonsView: View {
    var title: String
    var buttonStyle: ButtonViewStyle
    var action: () -> Void
    
    var body: some View {
        switch buttonStyle {
        case .primary:
            PrimaryButton(title: title, action: action)
        case .destructive:
            DestructiveButton(title: title, action: action)
        case .custom:
            CustomButton(title: title, action: action)
        }
    }
}

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(ColorConstants.purpleColor)
                )
                .padding(.horizontal)
        }
    }
}

struct DestructiveButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .foregroundStyle(.white)
                .font(.title3)
                .fontWeight(.regular)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.red)
                )
                .padding(.horizontal)
        }
    }
}

struct CustomButton: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(title)
                    .foregroundStyle(ColorConstants.purpleColor)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                Image(systemName: IconConstants.chevronRight)
                    .foregroundColor(ColorConstants.purpleColor)
            }
            .overlay(
                Rectangle()
                    .foregroundColor(ColorConstants.purpleColor)
                    .frame(height: 1)
                    .padding(.top, 10),
                alignment: .bottom
            )
        }
    }
}

#Preview {
    VStack {
        ButtonsView(title: "Hello, World!", buttonStyle: .primary, action: { })
        ButtonsView(title: "Delete", buttonStyle: .destructive, action: { })
        ButtonsView(title: "Custom", buttonStyle: .custom, action: { })
    }
}
