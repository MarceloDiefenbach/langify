//
//  LGButton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import SwiftUI

struct LGButton: View {
    
    let title: String
    let action: () -> Void
    let isClear: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
        }
        .background(isClear ? Color.clear : Color.blue)
        .cornerRadius(16)
        .overlay(
            isClear ? RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white, lineWidth: 2) : nil
        )
        .onTapGesture(perform: action)
    }
    
}
