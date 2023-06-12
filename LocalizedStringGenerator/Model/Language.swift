//
//  Language.swift
//  Langify
//
//  Created by Thaís Fernandes on 12/06/23.
//

import Foundation

enum Language: String, CaseIterable {
    case english = "en"
    case portuguese = "pt"
    case spanish = "es"
    case french = "fr"
    case japanese = "ja"
    case russian = "ru"
    case korean = "ko"
    
    var title: String {
        switch self {
            case .english:
                return "English"
            case .portuguese:
                return "Portuguese"
            case .spanish:
                return "Spanish"
            case .french:
                return "French"
            case .japanese:
                return "Japanese"
            case .russian:
                return "Russian"
            case .korean:
                return "Korean"
        }
    }
    }
