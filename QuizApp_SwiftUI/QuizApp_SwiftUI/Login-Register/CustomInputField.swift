//
//  CustomInputField.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 19.07.2024.
//

import SwiftUI

struct CustomInputField: View {
    let imageName: String
    let placeholderText: String
    var textCase: Text.Case?
    var keyboardType: UIKeyboardType?
    var textContentType: UITextContentType?
    var textInputAutoCapital: TextInputAutocapitalization?
    var isSecureField: Bool? = false
    @Binding var text: String

    var body: some View {
        VStack {
            HStack {
                Image(systemName: self.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.darkGray))

                if self.isSecureField ?? false {
                    SecureField(self.placeholderText, text: self.$text)
                        .textContentType(self.textContentType != nil ? self.textContentType : .none)
                } else {
                    TextField(self.placeholderText, text: self.$text, onEditingChanged: { _ in
                        self.text = setTextCase(text: self.text)
                    })
                    .keyboardType(self.keyboardType != nil ? self.keyboardType! : .default)
                    .textContentType(self.textContentType != nil ? self.textContentType : .none)
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(self.textInputAutoCapital != nil ? self.textInputAutoCapital : .none)
                    .onChange(of: self.text) { _ in
                        self.text = setTextCase(text: self.text)
                    }
                }
            }

            Divider()
                .background(Color(.darkGray))
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(imageName: "envelope", placeholderText: "Email", isSecureField: false, text: .constant(""))
    }
}

extension CustomInputField {
    func setTextCase(text: String) -> String {
        if let textCase = textCase {
            if textCase == .uppercase {
                return text.uppercased()
            } else if textCase == .lowercase {
                return text.lowercased()
            }
        }
        return text
    }
}
