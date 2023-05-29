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
                        Text(viewModel.translated)
                            .foregroundColor(.white)
                    }.padding(.top, 32)
                }
                .frame(maxHeight: 600)
                
                Spacer()
                
                HStack {
                    LGButton(title: "Back to text editor view", action: {
                        viewModel.currentPage = .text
                    }, isClear: true)
                    
                    LGButton(title: "Copy to clipboard", action: {
                        TranslateService.shared.copyKeyValueStringToClipboard()
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
