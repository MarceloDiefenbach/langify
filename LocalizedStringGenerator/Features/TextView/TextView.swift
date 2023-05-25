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
    
    @State var text: String = ""
    @State private var isChecked = false
    @State private var localizedStrings: [String: String] = [:]
    @State private var localizedTranslatedStrings: [String: String] = [:]
    
    var body: some View {
        ZStack {
            HStack {
                VStack {
                    Text("Paste here your default LocalizedStrings")
                    TextEditor(text: $text)
                        .font(.body)
                        .background(Color.primary.colorInvert())
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.black, lineWidth: 1 / 3)
                                .opacity(0.3)
                        )
                    HStack {
                        Toggle("English", isOn: $isChecked)
                            .toggleStyle(CheckboxToggleStyle())
                        Spacer()
                        Text("\(text.count)/1.000")
                            .padding(.trailing, 8)
                        HStack {
                            Text("Translate")
                                .foregroundColor(.white)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 24)
                        }
                        .background(.blue)
                        .cornerRadius(16)
                        .onTapGesture(perform: {
                            TranslateService.shared.parseKeyValueStringTranslate(string: text, completion: { value in
                                localizedTranslatedStrings = value
                                viewModel.currentPage = .result
                            })
                        })
                    }
                }
            }
            .padding(.all, 20)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}

//"singleDeviceTitle" = "Um dispositivo";
//"singleDeviceDescription" = "Jogue localmente";
//"multiplayerTitle" = "Multiplayer";
//"multiplayerDescription" = "Vários disposivos onlie";
//"howToPlayButton" = "Como jogar?";
//"storeButton" = "Loja";
//"aboutUsButton" = "Sobre nós";

