//
//  ResultHeader.swift
//  Langify
//
//  Created by Marcelo Diefenbach on 13/07/23.
//

import Foundation
import SwiftUI

struct ResultHeader: View {
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
            .padding(.vertical)
            .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)

            if showOriginalValue == true {
                HStack {
                    Text(secondLabel)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.vertical)
                .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)
            }

            HStack {
                Text(thirdLabel)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(.vertical)
            .frame(minWidth: 50, maxWidth: .infinity, maxHeight: .infinity)
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ResultHeader_Previews: PreviewProvider {
    static var previews: some View {
        ResultHeader(firstLabel: "Key", secondLabel: "Original value", thirdLabel: "Translated value", showOriginalValue: .constant(true))
    }
}
