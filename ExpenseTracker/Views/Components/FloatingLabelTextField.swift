//
//  FloatingLabelTextField.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 03/11/23.
//

import SwiftUI

public struct FloatingLabelTextField: View {
    @State private var placeHolder: String = ""
    @State private var placeHolderLabel: String = ""
    private var placeHolderValue: String = ""
    @Binding var text: String
    @State private var isActive: Bool = false
    
    public init(placeHolder: String = "Please Input",
                text: Binding<String> = .constant("") ) {
        self._text = text
        self.placeHolderValue = placeHolder
    }
    
    public var body: some View {
        return ZStack(alignment: .leading) {
            TextField(placeHolder, text: $text, onEditingChanged: { edit in
                self.updateEditMode(edit: edit)
            })
                .font(.system(size: 20))
                .padding()
                .overlay( RoundedRectangle(cornerRadius: 8)
                    .stroke(ColorConstants.purpleColor, lineWidth: 1)
                    .frame(height: 55))
                .foregroundColor(Color.black)
                .accentColor(.gray)
                .onAppear {
                    self.placeHolder = self.placeHolderValue
                }
            
            // Text which acts as a floating label
            Text("\(placeHolderLabel)")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .animation(.interactiveSpring())
                .background(Color.white)
                .padding(EdgeInsets(top: 0, leading:16, bottom: 55
                    , trailing: 0))
            
        }
    }
    
    // Function to remove focus from text field if tapped on another object.
    private func updateEditMode(edit: Bool) {
        if edit {
            self.placeHolderLabel = self.placeHolderValue
            self.placeHolder = ""
            self.isActive = true
        } else {
            if self.text.count == 0 {
                self.placeHolder = self.placeHolderValue
                self.placeHolderLabel = ""
            }
            self.isActive = false
        }
    }
}
