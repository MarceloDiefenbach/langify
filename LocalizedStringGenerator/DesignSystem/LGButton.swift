//
//  LGButton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import SwiftUI

extension ButtonStyle where Self == LGButton {
    static var lgButton: Self {
        return .init()
    }
    
    static var lgClearButton: Self {
        return .init(isClear: true)
    }
    
    static func lgButton(isClear: Bool) -> Self {
        return .init(isClear: isClear)
    }
}

struct LGButton: ButtonStyle {
    var isClear: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .buttonBorderShape(.roundedRectangle)
            .background(isClear ? Color.white.opacity(0.01) : Color.blue)
            .cornerRadius(16)
            .overlay(content: {
                if isClear {
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 2)
                }
            })
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.linear, value: configuration.isPressed)
    }
}
