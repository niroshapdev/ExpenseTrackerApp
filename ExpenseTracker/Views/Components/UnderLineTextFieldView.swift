//
//  UnderlineTextFieldView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 03/11/23.
//

import Foundation
import SwiftUI

struct UnderlineTextFieldView<TextFieldView>: View where TextFieldView: View {
    
    @Binding var text: String
    let textFieldView: TextFieldView
    let placeholder: String
    
    init(text: Binding<String>, textFieldView: TextFieldView, placeholder: String) {
            self._text = text
            self.textFieldView = textFieldView
            self.placeholder = placeholder
            UITextField.appearance().tintColor = .black
        }
    var body: some View {
        underlineTextFieldView
    }
}

extension UnderlineTextFieldView {
    
    private var underlineTextFieldView: some View {
        VStack {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    placeholderView
                }
                textFieldView
                    .padding(.leading, 12)
                    .accentColor(.black)
            }
            underlineView
        }
    }
    
    private var placeholderView: some View {
        Text(placeholder)
            .font(.title3)
            .foregroundColor(ColorConstants.purpleColor)
            .opacity(0.5)
            .padding(.leading, 12)
    }
    
    private var underlineView: some View {
        Rectangle().frame(height: 1)
            .foregroundColor(ColorConstants.purpleColor)
    }
}
