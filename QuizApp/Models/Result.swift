//
//  Result.swift
//  QuizApp
//
//  Created by five on 16/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct Result{
    let quizId: Int;
    let userId: Int;
    let time: Double;
    let noOfCorrect: Int;
    
    init(quizId: Int, userId: Int, time: Double, noOfCorrect: Int) {
        self.quizId = quizId
        self.userId = userId
        self.time = time
        self.noOfCorrect = noOfCorrect
    }
    
    enum CodingKeys: String, CodingKey {
        case quizId = "quiz_id"
        case userId = "user_id"
        case time
        case noOfCorrect = "no_of_correct"
    }
}

extension Result: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(quizId, forKey: .quizId)
        try container.encode(time, forKey: .time)
        try container.encode(userId, forKey: .userId)
        try container.encode(noOfCorrect, forKey: .noOfCorrect)
    }
}

extension Result: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.quizId = try values.decode(Int.self, forKey: .quizId)
        self.time = try values.decode(Double.self, forKey: .time)
        self.noOfCorrect = try values.decode(Int.self, forKey: .noOfCorrect)
        self.userId = try values.decode(Int.self, forKey: .userId)

    }
}


