//
//  CoordinatorSingleton.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation

class CoordinatorViewModel: ObservableObject {
    @Published var currentPage: Page = .text
    @Published var originalTextDictionary: [String: String] = [:]
    @Published var translatedTextDictionary: [String: String] = [:]
    @Published var translatedText: String = ""
    @Published var text: String = "\"howToPlayButton\" = \"Como jogar esse incrível jogo?\";\n\"otherBuqweqsatton\" = \"outro botão\";\n\"otherBuqwtton\" = \"outro botão\";\n\"otherBuqdasdasdaswtton\" = \"outro botão\";\n\"otherB213123uqwtton\" = \"outro botão\";"
    
    
    func createDictionary(from string: String) -> [String: String] {
        var dictionary = [String: String]()
        
        // Dividir a string por ponto e vírgula para obter pares chave-valor individuais
        let keyValuePairs = string.components(separatedBy: ";")
        
        // Percorrer cada par chave-valor
        for pair in keyValuePairs {
            // Dividir o par em chave e valor usando "=" como separador
            let components = pair.components(separatedBy: "=")
            
            // Verificar se o par é válido
            if components.count == 2 {
                // Remover espaços em branco extras e caracteres de escape
                let key = components[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let value = components[1].trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Remover as aspas duplas do início e fim do valor
                let sanitizedValue = value.replacingOccurrences(of: "\"", with: "")
                
                // Remover as aspas duplas do início e fim da chave
                let sanitizedKey = key.replacingOccurrences(of: "\"", with: "")
                
                // Adicionar o par chave-valor ao dicionário
                dictionary[sanitizedKey] = sanitizedValue
            }
        }
        
        return dictionary
    }
}
//"howToPlayButton" = "Como jogar esse incrível jogo?";
//"otherBuqweqsatton" = "outro botão";
//"otherBuqwtton" = "outro botão";
//"otherBuqdasdasdaswtton" = "outro botão";
//"otherB213123uqwtton" = "outro botão";
//"otherBuqasdasdweqsatton" = "outro botão";
//"oasdasdtherBuqwtton" = "outro botão";
//"otherBuasdasdqdasdasdaswtton" = "outro botão";
//"otherB213123uqasdasdwtton" = "outro botão";`
