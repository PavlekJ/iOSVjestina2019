//
//  Quizzes.swift
//  QuizApp
//
//  Created by five on 03/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct Quizzes{
    let quizzes: [Quiz]
    
    enum CodingKeys: String, CodingKey{
        case quizzes
    }
    
    
    
    func categories() -> [String] {
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        let uniqueCategories = Array(Set(categories))
        return uniqueCategories
    }
}

extension Quizzes: Decodable {
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.quizzes = try values.decode([Quiz].self, forKey: .quizzes)
    }
    
}
