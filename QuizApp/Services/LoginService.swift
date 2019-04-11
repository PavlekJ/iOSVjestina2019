//
//  LoginService.swift
//  QuizApp
//
//  Created by five on 11/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

class LoginService{
    static let shared = LoginService()
    
    func fetchToken(username: String, password: String, completion: @escaping ((Token?) -> Void)){
        guard let url = URL(string: "http://iosquiz.herokuapp.com/api/session?username=\(username)&password=\(password)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for 
                    completion(nil)
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                completion(nil)
                return
            }
            
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(Token.self, from:
                    data)
                completion(model)
            } catch let parsingError {
                print("Error", parsingError)
                completion(nil)
            }
            
            
            
        }
        task.resume()
        
        
    }
    
    
}
