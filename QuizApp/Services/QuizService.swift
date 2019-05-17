//
//  QuizService.swift
//  QuizApp
//
//  Created by five on 03/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizService {
    static let shared = QuizService()
    
    let codeAnswers = [200, 400, 401, 403, 404]

    func fetchRank(quizId: Int, completion: @escaping ([Rank]?) -> Void){
        
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/score?quiz_id=\(quizId)") else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            completion(nil)
            return
        }
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    
                    print(error?.localizedDescription ?? "Response Error")
                    completion(nil)
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode([Rank].self, from:
                    dataResponse) //Decode JSON Response Data
                completion(model)
            } catch let parsingError {
                print("Error", parsingError)
                completion(nil)
            }
        }
        task.resume()
        
        
        
    }
    func fetchQuizzes(completion: @escaping (Quizzes?) -> Void){
        guard let url = URL(string: "https://iosquiz.herokuapp.com/api/quizzes") else {
            completion(nil)
            return
        }

        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    
                    print(error?.localizedDescription ?? "Response Error")
                    completion(nil)
                    return }
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(Quizzes.self, from:
                    dataResponse) //Decode JSON Response Data
                completion(model)
            } catch let parsingError {
                print("Error", parsingError)
                completion(nil)
            }
        }
        task.resume()
    }
    
    
    func sendQuizResult(result: Result, completion: @escaping ((Int?) -> Void)) {
        guard let url = URL(string: "http://iosquiz.herokuapp.com/api/result") else {
            print("URL NE POSTOJI")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            completion(nil)
            return
        }
        print(3)
        
        request.setValue(token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        guard let jsonResult = try? encoder.encode(result) else {
            fatalError("JSON result needs to exist at this point")
        }
        
        request.httpBody = jsonResult
        
        print(4)
        
        
        
        let task = URLSession.shared.dataTask(with: request) { (_, response, error) in
            guard let response = response as? HTTPURLResponse,
                error == nil else {
                    completion(nil)
                    return
            }
            
            if self.codeAnswers.contains(response.statusCode) {
                completion(response.statusCode)
            }
        }
        task.resume()
        
        
    }
    
    
    func fetchQuizImage(imageUrl: String?, completion: @escaping ((UIImage?) -> Void)){
        guard let imageUrlString = imageUrl else {
            completion(nil)
            return
        }
        if let url = URL(string: imageUrlString) {
            
            let request = URLRequest(url: url)
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let image = UIImage(data: data)
                    completion(image)
                } else {
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}
