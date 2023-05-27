//
//  LocalizedStringGeneratorApp.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import SwiftUI

@main
struct LocalizedStringGeneratorApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .frame(width: 800, height: 600)
                .preferredColorScheme(.dark)
                .onAppear(){
//                    GPTService.shared.verifyAPIKey(completion: { isValid in })
                }
        }
    }
}
