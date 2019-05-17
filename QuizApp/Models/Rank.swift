//
//  Rank.swift
//  QuizApp
//
//  Created by five on 17/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation

struct Rank{
    let username: String;
    let score: String;
    
    enum CodingKeys: String, CodingKey {
        case username
        case score
    }
}

extension Rank: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try values.decode(String.self, forKey: .username)
        self.score = try values.decode(String.self, forKey: .score)
    }
}
