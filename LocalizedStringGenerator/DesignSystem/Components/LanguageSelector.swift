//
//  LanguageSelector.swift
//  Langify
//
//  Created by Thaís Fernandes on 12/06/23.
//

import Foundation
import SwiftUI

struct LanguageSelector: View {
    @Binding var selectedLanguage: Language
    
    var body: some View {
        Picker("", selection: $selectedLanguage) {
            ForEach(Language.allCases, id: \.self) { category in
                Text(category.title).tag(category)
            }
        }
        .pickerStyle(DefaultPickerStyle())
    }
}
