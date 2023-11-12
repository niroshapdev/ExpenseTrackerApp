//
//  DatePickerTextField.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 08/11/23.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let delegate = DatePickerDelegate()
    @Binding var isDoneButtonTapped: Bool
    
    public var placeholder: String
    @Binding public var date: Date?
    
    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.addTarget(self.delegate, action: #selector(self.delegate.dateValueChanged), for: .valueChanged)
        
        textField.placeholder = placeholder
        textField.inputView = datePicker
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 2
        textField.layer.borderColor = ColorConstants.purpleColor.cgColor
        textField.layer.cornerRadius = 10
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain,
                                         target: delegate, action: #selector(delegate.doneButtonTapped))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        delegate.onDateValueChanged = {
            date = datePicker.date
        }
        
        delegate.onDoneButtonTapped = {
            if date == nil {
                date = datePicker.date
            }
            textField.resignFirstResponder()
            isDoneButtonTapped = true
        }
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = Utils.dateToString(date: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class DatePickerDelegate {
        public var onDateValueChanged: (() -> Void)?
        public var onDoneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            onDateValueChanged?()
        }
        
        @objc func doneButtonTapped() {
            onDoneButtonTapped?()
        }
    }
    
    class Coordinator {}
}
