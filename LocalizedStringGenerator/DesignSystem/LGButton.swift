//
//  LGButton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import SwiftUI

extension ButtonStyle where Self == LGButton {
    static var lgButtonPrimary: Self {
        return .init()
    }
    
    static var lgButtonSecondary: Self {
        return .init(backgroundColor: .white, textColor: .black)
    }
    
    static func lgButton(isClear: Bool) -> Self {
        return .init(isClear: isClear)
    }
}

struct LGButton: ButtonStyle {
    var isClear: Bool = false
    var backgroundColor: Color = .blue
    var textColor: Color = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor)
            .font(Font.body.bold())
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .buttonBorderShape(.roundedRectangle)
            .background(isClear ? Color.white.opacity(0.01) : backgroundColor)
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
