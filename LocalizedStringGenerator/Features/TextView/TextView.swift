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
    @State var selectedCategory: CategorySelector.Category = .english
    let maxCharacters: Int = 1000
    @State var isTranslating: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text("Paste here your default LocalizedStrings")
                    TextEditor(text: $viewModel.text)
                        .font(.body)
                        .background(Color.primary.colorInvert())
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.black, lineWidth: 1 / 3)
                                .opacity(0.3)
                        )
                        .onChange(of: viewModel.text) { newText in
                                        if newText.count > maxCharacters {
                                            viewModel.text = String(newText.prefix(maxCharacters))
                                        }
                                    }
                    HStack {
                        Text("Translate to")
                        CategorySelector(selectedCategory: $selectedCategory)

                        Spacer()
                        HStack {
                            Text("Translate")
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                        }
                        .background(.blue)
                        .cornerRadius(16)
                        .onTapGesture(perform: {
                            self.isTranslating = true
                            
                        
                            TranslateService.shared.translateLocalizableStrings(text: viewModel.text, targetLanguage: selectedCategory.rawValue) { translatedText, error in
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
                        })
                    }
                }
            }
            .padding(.all, 20)
            if self.isTranslating {
                ZStack {
                    Color.blue.opacity(0.3)
                    ProgressView("Translating")
                        .padding()
                }.ignoresSafeArea()
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}

struct CategorySelector: View {
    enum Category: String, CaseIterable {
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

    
    @Binding var selectedCategory: Category
    
    var body: some View {
        Picker("", selection: $selectedCategory) {
            ForEach(Category.allCases, id: \.self) { category in
                Text(category.title).tag(category)
            }
        }
        .pickerStyle(DefaultPickerStyle())
    }
}

//"singleDeviceTitle" = "Um dispositivo";
//"singleDeviceDescription" = "Jogue localmente";
//"multiplayerTitle" = "Multiplayer";
//"multiplayerDescription" = "Vários disposivos onlie";
//"howToPlayButton" = "Como jogar?";
////MARK: - titulo da parte
//"storeButton" = "Loja";
//"aboutUsButton" = "Sobre nós";
