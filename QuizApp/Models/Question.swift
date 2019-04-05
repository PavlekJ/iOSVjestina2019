//
//  Question.swift
//  QuizApp
//
//  Created by five on 03/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct Question {
    let id: Int
    let question: String
    let answers: [String]
    let correct_answer : Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case answers
        case correct_answer
    }
}


extension Question: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.question = try values.decode(String.self, forKey: .question)
        self.correct_answer = try values.decode(Int.self, forKey: .correct_answer)
        self.answers = try values.decode([String].self, forKey: .answers)
    }
}
