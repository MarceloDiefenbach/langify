//
//  ResultRow.swift
//  Langify
//
//  Created by Marcelo Diefenbach on 10/07/23.
//

import Foundation
import SwiftUI

struct ResultRow: View {
    var firstLabel: String
    var secondLabel: String
    var thirdLabel: String
    @Binding var showOriginalValue: Bool

    var body: some View {
        HStack {
            HStack {
                Text(firstLabel)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.all)
            .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)
            
            if showOriginalValue == true {
                HStack {
                    Text(secondLabel)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.all)
                .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.2))
                .cornerRadius(8)
            }
            
            HStack {
                Text(thirdLabel)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.all)
            .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        ResultRow(firstLabel: "Example Key", secondLabel: "Example Value", thirdLabel: "Valor traduzido para a lingua escolhida", showOriginalValue: .constant(true))
    }
}
