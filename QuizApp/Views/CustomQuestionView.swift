//
//  CustomQuestionView.swift
//  QuizApp
//
//  Created by five on 03/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit



class CustomQuestionView : UIView{
    let questionLabel = UILabel()
    
    let answerButton1 = UIButton()
    let answerButton2 = UIButton()
    let answerButton3 = UIButton()
    let answerButton4 = UIButton()
    
    var answerButtons : [UIButton] = []

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        answerButtons += [answerButton1, answerButton2, answerButton3, answerButton4]
        self.setupView()
    }
    
    
    convenience init(frame: CGRect, question: Question){
        self.init(frame: frame) // calls the initializer above
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func setupView(){
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }
    
    
    func addSubviews(){
        self.addSubview(questionLabel)
        answerButtons.forEach{ button in
            self.addSubview(button)
        }
    
    }
    
    func styleSubviews(){
        
        questionLabel.textColor = .black
        questionLabel.numberOfLines = 0
        questionLabel.lineBreakMode = .byWordWrapping
        
        answerButtons.forEach{ button in
            button.backgroundColor = UIColor(red:0.66, green:0.66, blue:0.66, alpha:1.0)
            button.layer.cornerRadius = 20
            button.setTitleColor(.white, for: .normal)
        }
        
        answerButton1.tag = 0
        answerButton2.tag = 1
        answerButton3.tag = 2
        answerButton4.tag = 3
        
    }
    
    func positionSubviews(){
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.widthAnchor.constraint(equalToConstant: 270),
            questionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            questionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        
        answerButtons.forEach{ button in
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 270),
                button.heightAnchor.constraint(equalToConstant: 40),
                button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                button.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: 0)
                ])
            
            
            
            
            
        }
        
        
        
        
        
        
    
    }
    
    
    
    
    
    
    
}
