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
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Chave")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .frame(width: 190)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    Text("Original")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .frame(width: 190)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                    Text("Traduzido")
                        .multilineTextAlignment(.leading)
                        .padding(.all)
                        .frame(width: 190)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                }
                ForEach(viewModel.translatedTextDictionary.sorted(by: <), id: \.key) { key, value in
                    ResultRow(key: key, value: viewModel.originalTextDictionary[key] ?? "", translatedValue: value)
                }
            }
            .frame(maxHeight: 600)
            
            HStack {
                Button("Back to text editor view") {
                    viewModel.currentPage = .text
                }
                .buttonStyle(.lgClearButton)
                
                Button("Copy to clipboard") {
                    TranslateService.shared.copyKeyValueStringToClipboard()
                }
                .buttonStyle(.lgClearButton)
            }
            .padding(.vertical, 32)
        }
        .frame(width: 800, height: 600)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
