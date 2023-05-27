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
        ZStack {
            VStack {
                
                ScrollView(.vertical) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.translated.sorted(by: { $0.key < $1.key }), id: \.key) { pair in
                            Text("\(pair.key) = \(pair.value)").frame(width: 800)
                                .foregroundColor(.white)
                        }
                    }.padding(.top, 32)
                }
                .frame(maxHeight: 600)
                
                Spacer()
                
                HStack {
                    LGButton(title: "Back to text editor view", action: {
                        viewModel.currentPage = .text
                    }, isClear: true)
                    
                    LGButton(title: "Copy to clipboard", action: {
                        TranslateService.shared.copyKeyValueStringToClipboard(from: TranslateService.shared.localizedTranslatedStrings)
                    }, isClear: false)
                    
                }
                .padding(.vertical, 32)
            }
        }
        .frame(width: 800, height: 600)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
