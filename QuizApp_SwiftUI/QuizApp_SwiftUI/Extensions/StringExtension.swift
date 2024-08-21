//
//  StringExtension.swift
//  QuizApp_SwiftUI
//
//  Created by Şevval Mertoğlu on 20.08.2024.
//

import Foundation
import SwiftUI

extension String {
    func base64Decode() -> String? {
        if let data = Data(base64Encoded: self, options: [.ignoreUnknownCharacters]) {
            return String(data: data, encoding: .utf16)
        }
        return nil
    }
}
