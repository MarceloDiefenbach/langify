//
//  CoordinatorSingleton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation

class CoordinatorViewModel: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var originalTextDictionary: [String: String] = [:]
    @Published var translatedTextDictionary: [String: String] = [:]
    @Published var translatedText: String = ""
    @Published var text: String = "\"howToPlayButton\" = \"Como jogar esse incrível jogo?\";\n\"otherButton\" = \"outro botão\";"
}
