//
//  CoordinatorView.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import SwiftUI
import Combine

enum Page {
    case home, text, result
}

struct CoordinatorView: View {
    
    @StateObject var viewModel = CoordinatorViewModel()
    
    var body: some View {
        ZStack {
            if viewModel.currentPage == .result {
                ResultView()
                    .environmentObject(viewModel)
            } else if viewModel.currentPage == .text {
                TextView()
                    .environmentObject(viewModel)
            } else if viewModel.currentPage == .home {
                HomeView()
                    .environmentObject(viewModel)
            }
        }
    }
}


struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}

