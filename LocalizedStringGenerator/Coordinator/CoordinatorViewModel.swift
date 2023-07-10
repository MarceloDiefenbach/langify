//
//  CoordinatorSingleton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation

class CoordinatorViewModel: ObservableObject {
    @Published var currentPage: Page = .home
    @Published var translated: String = ""
    @Published var text: String = "\"howToPlayButton\" = \"Como jogar?\";"
}
