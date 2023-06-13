//
//  ContentView.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import SwiftUI

struct LocalizedString: Hashable {
    var key: String
    var value: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(key)
        hasher.combine(value)
    }
}

struct TextView: View {
    @EnvironmentObject var viewModel: CoordinatorViewModel
    
    @State private var isChecked = false
    @State private var selectedCategory: Language = .english
    @State private var isTranslating: Bool = false
    
    var body: some View {
        VStack {
            Text("Paste here your default LocalizedStrings")
                .font(.title3)
                .fontWeight(.bold)
            
            TextEditor(text: $viewModel.text)
                .font(.body)
                .background(Color.primary.colorInvert())
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1 / 3)
                        .opacity(0.3)
                )
            
            HStack {
                Text("Translate to")
                
                LanguageSelector(selectedLanguage: $selectedCategory)
                
                Spacer()
                
                HStack {
                    Text("Translate")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 24)
                }
                .background(.blue)
                .cornerRadius(16)
                .onTapGesture { onTapTranslate() }
            }
            .padding(.top, 10)
        }
        .padding(20)
        .overlay {
            if isTranslating {
                ZStack {
                    Color.blue.opacity(0.3)
                    ProgressView("Translating")
                        .padding()
                }
                .ignoresSafeArea()
            }
        }
    }
    
    func onTapTranslate() {
        self.isTranslating = true
        
        TranslateService
            .shared
            .translateLocalizableStrings(
                text: viewModel.text,
                targetLanguage: selectedCategory.rawValue
            ) { translatedText, error in
            
            if let error = error {
                // Lidar com o erro
                print("Erro durante a tradução: \(error)")
                return
            }
            
            if let translatedText = translatedText {
                // Faça algo com o texto traduzido retornado
                DispatchQueue.main.async {
                    viewModel.translated = translatedText
                    self.isTranslating = false
                    print("Texto traduzido: \(viewModel.translated)")
                    viewModel.currentPage = .result
                    TranslateService.shared.copyKeyValueStringToClipboard()
                }
            } else {
                // Caso não seja possível obter o texto traduzido
                print("Não foi possível obter o texto traduzido")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
