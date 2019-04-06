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
