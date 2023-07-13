//
//  ResultView.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: CoordinatorViewModel
    @State var showOriginalValue: Bool = true
    
    var body: some View {
        VStack {
            VStack (spacing: 0) {
                HStack {
                    Button("Back", action: {
                        viewModel.currentPage = .text
                    })
                    .buttonStyle(.lgButtonPrimary)
                    .padding(.trailing, 8)
                    
                    Toggle(isOn: $showOriginalValue) {
                        Text("Show Original Value")
                            .font(Font.caption)
                    }.toggleStyle(SwitchToggleStyle())
                    
                    Spacer()
                    
                    Button("Copy translated .strings", action: {
                        TranslateService.shared.copyKeyValueStringToClipboard(text: viewModel.translatedText)
                    }).buttonStyle(.lgButtonSecondary)
                }
                
                HStack {
                    Text("Translation results")
                        .font(Font.largeTitle.bold())
                    Spacer()
                }
                .padding(.vertical, 16)
                
                Divider()
                
                ResultHeader(firstLabel: "Key",
                             secondLabel: "Original",
                             thirdLabel: "Translated",
                             showOriginalValue: $showOriginalValue
                )
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.translatedTextDictionary.sorted(by: <), id: \.key) { key, value in
                        ResultRow(firstLabel: key,
                                  secondLabel: viewModel.originalTextDictionary[key] ?? "",
                                  thirdLabel: value,
                                  showOriginalValue: $showOriginalValue
                        )
                    }
                }
            }
        }
        .padding(.all, 32)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
