////
////  GPTService.swift
////  LocalizedStringGenerator
////
////  Created by Marcelo Diefenbach on 28/04/23.
////
//
//import Foundation
//
//class GPTService {
//    
//    static let shared = GPTService()
//    var tokensUsed: Int = 0
//    var apiKey: String = ""
//    var isKeyValide: Bool = false
//    
//    init(){
//        apiKey = UserDefaultsService.shared.fetchString(forKey: GlobalStrings.shared.APIKEY) ?? ""
//        if apiKey != "" {
//            isKeyValide = true
//        }
//    }
//    
//    func removeBrackets(from string: String) -> String {
//        return string.replacingOccurrences(of: "[", with: "")
//                     .replacingOccurrences(of: "]", with: "")
//    }
//    
//    func getChatCompletion(message: String, toLanguague: String, completion: @escaping (String) -> Void) {
//        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(UserDefaultsService.shared.fetchString(forKey: GlobalStrings.shared.APIKEY) ?? "")", forHTTPHeaderField: "Authorization")
//
//        let messegaWithPromtp = "only translate to \(toLanguague) and return between [] :\(message)"
//        
//        let parameters = [
//            "model": "gpt-3.5-turbo",
//            "messages": [["role": "user", "content": messegaWithPromtp]],
//        ] as [String : Any]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//        } catch let error {
//            completion("error")
//            return
//        }
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            
//            guard let data = data, error == nil else {
//                completion("error")
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse else {
//                completion("error")
//                return
//            }
//
//            let statusCode = httpResponse.statusCode
//            if statusCode == 200 {
//                self.isKeyValide = true
//            } else {
//                self.isKeyValide = false
//                print(httpResponse)
//                print("Erro - Status Code: \(statusCode)")
//            }
//
//            do {
//                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//                      let id = json["id"] as? String,
//                      let created = json["created"] as? Int,
//                      let message = (json["choices"] as? [[String: Any]])?.first?["message"] as? [String: Any],
//                      let messageContent = message["content"] as? String,
//                      let finishReason = (json["choices"] as? [[String: Any]])?.first?["finish_reason"] as? String,
//                      let promptTokens = (json["usage"] as? [String: Any])?["prompt_tokens"] as? Int,
//                      let completionTokens = (json["usage"] as? [String: Any])?["completion_tokens"] as? Int,
//                      let totalTokens = (json["usage"] as? [String: Any])?["total_tokens"] as? Int
//                else {
//                    throw NSError(domain: "JSON parsing error", code: 0, userInfo: nil)
//                }
//
//                let chatCompletion = ChatCompletion(id: id, created: Date(timeIntervalSince1970: TimeInterval(created)), message: messageContent, finishReason: finishReason, promptTokens: promptTokens, completionTokens: completionTokens, totalTokens: totalTokens)
//                
//                self.tokensUsed = self.tokensUsed + Int(chatCompletion.totalTokens)
//                print("\(self.tokensUsed)")
//
//                completion(self.removeBrackets(from: chatCompletion.message))
//            } catch let error {
//                completion("error")
//            }
//        }.resume()
//    }
//    
////    func verifyAPIKey(completion: @escaping (Bool) -> Void) {
////        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
////        var request = URLRequest(url: url)
////        request.httpMethod = "POST"
////        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
////        print(UserDefaultsService.shared.fetchString(forKey: GlobalStrings.shared.APIKEY))
////        request.addValue("Bearer \(UserDefaultsService.shared.fetchString(forKey: GlobalStrings.shared.APIKEY) ?? "")", forHTTPHeaderField: "Authorization")
////        
////        let parameters = [
////            "model": "gpt-3.5-turbo",
////            "messages": [["role": "user", "content": "Responda apenas \"sim\" ou \"não\". Você é humano?"]],
////        ] as [String : Any]
////
////        do {
////            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
////        } catch let error {
////            completion(false)
////            return
////        }
////
////        URLSession.shared.dataTask(with: request) { data, response, error in
////            guard let data = data, error == nil else {
////                completion(false)
////                return
////            }
////            guard let httpResponse = response as? HTTPURLResponse else {
////                completion(false)
////                return
////            }
////            
////            let statusCode = httpResponse.statusCode
////            if statusCode == 200 {
////                self.isKeyValide = true
////            } else {
////                print(httpResponse)
////                print("Erro - Status Code: \(statusCode)")
////            }
////
////            do {
////                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
////                      let id = json["id"] as? String,
////                      let created = json["created"] as? Int,
////                      let message = (json["choices"] as? [[String: Any]])?.first?["message"] as? [String: Any],
////                      let messageContent = message["content"] as? String,
////                      let finishReason = (json["choices"] as? [[String: Any]])?.first?["finish_reason"] as? String,
////                      let promptTokens = (json["usage"] as? [String: Any])?["prompt_tokens"] as? Int,
////                      let completionTokens = (json["usage"] as? [String: Any])?["completion_tokens"] as? Int,
////                      let totalTokens = (json["usage"] as? [String: Any])?["total_tokens"] as? Int
////                else {
////                    throw NSError(domain: "JSON parsing error", code: 0, userInfo: nil)
////                }
////
////                let chatCompletion = ChatCompletion(id: id, created: Date(timeIntervalSince1970: TimeInterval(created)), message: messageContent, finishReason: finishReason, promptTokens: promptTokens, completionTokens: completionTokens, totalTokens: totalTokens)
////                
////                print(chatCompletion.message)
////                
////                if chatCompletion.message.contains("Sim") || chatCompletion.message.contains("Não") {
////                    completion(true)
////                } else {
////                    completion(false)
////                }
////                
////            } catch let error {
////                completion(false)
////            }
////        }.resume()
////    }
//}
