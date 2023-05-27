//
//  TranslateService.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation
import AppKit

class TranslateService {
    
    static let shared = TranslateService()
    var localizedTranslatedStrings: [String: String] = [:]
    
    func copyKeyValueStringToClipboard(from dictionary: [String: String]) {
        
        var result = ""
        
        for (key, value) in dictionary {
            let keyValueString = "\(key) = \(value)\n"
            result.append(keyValueString)
        }
        
        
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects(["\(result)" as NSString])
        let alert = NSAlert()
        alert.messageText = "String copied to the clipboard, paste it into your corresponding language's Localizable file."
        alert.runModal()
    }
    
    func parseKeyValueStringTranslate(string: String, toLanguage: String, completion: @escaping ([String: String]) -> Void) {
        let lines = string.split(separator: "\n")
        
        let dispatchGroup = DispatchGroup()
        
        var translatedStrings: [String: String] = [:]
        
        for line in lines {
            let parts = line.split(separator: "=").map { String($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            guard parts.count == 2 else {
                continue // Ignore lines that don't have two parts
            }
            
            let key = parts[0]
            
            dispatchGroup.enter()
            translateText(text: parts[1], targetLang: "\(toLanguage)") { result in
                switch result {
                case .success(let translation):
                    translatedStrings[key] = translation
                    dispatchGroup.leave()
                case .failure(let error):
                    translatedStrings[key] = "error"
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.localizedTranslatedStrings = translatedStrings
            self.copyKeyValueStringToClipboard(from: translatedStrings)
            completion(translatedStrings)
        }
    }
    
    func translateText(text: String, targetLang: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Defina a URL da rota de API
        let urlString = "https://gpt-treinador.herokuapp.com/translate"
        
        // Crie os dados JSON para enviar na requisição
        let json: [String: Any] = [
            "text": text,
            "source_lang" : "auto",
            "target_lang": "\(targetLang)"
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
            
            // Crie a requisição HTTP POST
            var request = URLRequest(url: URL(string: urlString)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // Inicie a sessão URLSession
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        // Analise a resposta JSON
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let translation = json["translation"] as? String {
                            completion(.success(translation))
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Falha ao analisar a resposta"])
                            completion(.failure(error))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            
            // Inicie a tarefa
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
}
