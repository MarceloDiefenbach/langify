//
//  ChatCompletion.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation

class ChatCompletion {
    let id: String
    let created: Date
    let message: String
    let finishReason: String
    let promptTokens: Int
    let completionTokens: Int
    let totalTokens: Int

    init(id: String, created: Date, message: String, finishReason: String, promptTokens: Int, completionTokens: Int, totalTokens: Int) {
        self.id = id
        self.created = created
        self.message = message
        self.finishReason = finishReason
        self.promptTokens = promptTokens
        self.completionTokens = completionTokens
        self.totalTokens = totalTokens
    }
}
