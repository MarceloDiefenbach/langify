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
    var translatedText: String = ""
    
    func copyKeyValueStringToClipboard() {
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects(["\(self.translatedText)" as NSString])
        let alert = NSAlert()
        alert.messageText = "String copied to the clipboard, paste it into your corresponding language's Localizable file."
        alert.runModal()
    }
    
    func translateLocalizableStrings(text: String, targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        let urlString = "https://gpt-treinador.herokuapp.com/translateFromJson"
        guard let url = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
//            completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
            return
        }
        
        let lines = text.components(separatedBy: "\n")
        print(lines)
        
        let parameters: [String: Any] = [
            "lines": lines,
            "source_language": "auto",
            "target_language": targetLanguage
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Erro ao serializar os parâmetros: \(error)")
            completion(nil, error) // Chame o completion handler com o erro
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Erro na solicitação: \(error)")
                completion(nil, error) // Chame o completion handler com o erro
                return
            }
            
            guard let data = data else {
                print("Dados vazios na resposta")
                completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
                return
            }
            
            if let translatedText = String(data: data, encoding: .utf8) {
                
                self.translatedText = translatedText
                completion(translatedText, nil) // Chame o completion handler com o texto traduzido
            } else {
                print("Não foi possível decodificar o texto traduzido")
                completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
            }
        }
        task.resume()
    }
    
    func translateLocalizableStringsWithDictionary(text: String, targetLanguage: String, completion: @escaping (String?, Error?) -> Void) {
        let urlString = "https://gpt-treinador.herokuapp.com/translateFromJson"
        guard let url = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
//            completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
            return
        }
        
        let lines = text.components(separatedBy: "\n")
//        print(lines)
        
        let parameters: [String: Any] = [
            "lines": lines,
            "source_language": "auto",
            "target_language": targetLanguage
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Erro ao serializar os parâmetros: \(error)")
            completion(nil, error) // Chame o completion handler com o erro
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Erro na solicitação: \(error)")
                completion(nil, error) // Chame o completion handler com o erro
                return
            }
            
            guard let data = data else {
                print("Dados vazios na resposta")
                completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
                return
            }
            
            if let translatedText = String(data: data, encoding: .utf8) {
                
                self.translatedText = translatedText
                completion(translatedText, nil) // Chame o completion handler com o texto traduzido
            } else {
                print("Não foi possível decodificar o texto traduzido")
                completion(nil, nil) // Chame o completion handler com valores nulos para indicar o erro
            }
        }
        task.resume()
    }
    
}
