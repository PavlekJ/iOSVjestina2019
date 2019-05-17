//
//  DynamicViewType.swift
//  QuizApp
//
//  Created by five on 05/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

protocol DynamicViewType where Self: UIView {
    associatedtype InitType
    
    var baseObject: InitType { get set }
    
    func addSubviews()
    func styleSubviews()
    func positionSubviews()
    
    func setup(with baseObject: InitType)
}

extension DynamicViewType {
    init(with baseObject: InitType) {
        self.init()
        self.baseObject = baseObject
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
        self.setup(with: baseObject)
    }
}

