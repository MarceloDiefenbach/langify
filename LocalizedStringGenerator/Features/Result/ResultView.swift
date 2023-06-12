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
            ScrollView(.vertical) {
                Text(viewModel.translated)
                    .foregroundColor(.white)
                    .padding(.top, 32)
            }
            .frame(maxHeight: 600)
            
            Spacer()
            
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
