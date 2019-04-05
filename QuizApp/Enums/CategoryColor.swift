//
//  CategoryColor.swift
//  QuizApp
//
//  Created by five on 05/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

enum categoryColor {
    case SPORTS
    case SCIENCE
    var Color: UIColor{
        switch self {
        case .SCIENCE:
            return UIColor(red:0.1, green:0.1, blue:0.54, alpha:1.0)
        case .SPORTS:
            return UIColor(red:0.1, green:0.54, blue:0.1, alpha:1.0)
        default:
            return UIColor(red:0.01, green:0.54, blue:0.16, alpha:1.0)
        }
    }
}
