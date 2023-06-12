//
//  HomeView.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: CoordinatorViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to")
                .foregroundColor(.white)
                .font(.system(size: 24, weight: .regular))
                .padding(.bottom, 4)
            
            Text("Langify")
                .foregroundColor(.white)
                .font(.system(size: 56, weight: .bold))
                .padding(.bottom, 80)
            
            HStack {
                Button("Start") {
                    viewModel.currentPage = .text
                }
                .buttonStyle(.lgButton)
            }
        }
        .frame(width: 800, height: 600)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
