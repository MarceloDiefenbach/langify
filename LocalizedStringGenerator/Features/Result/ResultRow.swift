//
//  ResultRow.swift
//  Langify
//
//  Created by Marcelo Diefenbach on 10/07/23.
//

import Foundation
import SwiftUI

struct ResultRow: View {
    var key: String
    var value: String
    var translatedValue: String

    var body: some View {
        HStack {
            HStack {
                Text(key)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.all)
            .frame(width: 190)
            .frame(maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)

            HStack {
                Text(value)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.all)
            .frame(width: 190)
            .frame(maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)

            HStack {
                Text(translatedValue)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.all)
            .frame(width: 190)
            .frame(maxHeight: .infinity)
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        ResultRow(key: "Example Key", value: "Example Value", translatedValue: "Valor traduzido para a lingua escolhida")
    }
}
