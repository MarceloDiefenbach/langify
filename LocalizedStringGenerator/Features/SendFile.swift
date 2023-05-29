////
////  SendFile.swift
////  Langify
////
////  Created by Marcelo Diefenbach on 29/05/23.
////
//
//import Foundation
//import SwiftUI
//
//struct SelectFileView: View {
//    @State private var text: String = ""
//    
//    var body: some View {
//        VStack {
//            TextField("Digite o texto a ser traduzido", text: $text)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            Button(action: {
//                translateButtonTapped()
//            }) {
//                Text("Traduzir")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
//            
//            Spacer()
//        }
//    }
//    
//    private func translateButtonTapped() {
//        guard !text.isEmpty else {
//            // Se o campo de texto estiver vazio, não fazer nada
//            return
//        }
//        
//        let sourceLanguage = "pt"
//        let targetLanguage = "en"
//        
//        translateLocalizableStrings(text: text, sourceLanguage: sourceLanguage, targetLanguage: targetLanguage)
//    }
//    
//    private func translateLocalizableStrings(text: String, sourceLanguage: String, targetLanguage: String) {
//        let urlString = "https://gpt-treinador.herokuapp.com/translateFromJson"
//        guard let url = URL(string: urlString) else {
//            print("URL inválida: \(urlString)")
//            return
//        }
//        
//        let parameters: [String: Any] = [
//            "lines": [text],
//            "source_language": sourceLanguage,
//            "target_language": targetLanguage
//        ]
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//        } catch {
//            print("Erro ao serializar os parâmetros: \(error)")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Erro na solicitação: \(error)")
//                return
//            }
//            
//            guard let data = data else {
//                print("Dados vazios na resposta")
//                return
//            }
//            
//            if let translatedText = String(data: data, encoding: .utf8) {
//                // Faça algo com o texto traduzido retornado
//                print("Texto traduzido: \(translatedText)")
//            } else {
//                print("Não foi possível decodificar o texto traduzido")
//            }
//        }
//        
//        task.resume()
//    }
//}
//
//struct SelectFileView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectFileView()
//    }
//}
