//
//  QuizTableViewCell.swift
//  QuizApp
//
//  Created by five on 05/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizTableViewCell: UITableViewCell {
    
    let quizImageView = UIImageView()
    let titleLabel = UILabel()
    let levelLabel = UILabel()
    let descriptionLabel = UILabel()
    
    
    var quiz: Quiz!
    
    static let cellIdentifier = "QuizTableViewCell"
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 8
            frame.size.height -= 2 * 9
            frame.origin.x += 15
            frame.size.width -= 2 * 16
            super.frame = frame
        }
    }

}

extension QuizTableViewCell: DynamicViewType {
    
    var baseObject: Quiz {
        get {
            return self.quiz
        }
        set {
            self.quiz = newValue
        }
    }
    
    typealias InitType = Quiz
    
    func setup(with baseObject: Quiz) {
        self.descriptionLabel.text = quiz.description
        self.titleLabel.text = quiz.title
        self.levelLabel.text = String(repeating: "⭐️", count: quiz.level)
        

        QuizService.shared.fetchQuizImage(imageUrl: quiz.image){ (image) in
            if image != nil {
                DispatchQueue.main.async {
                    self.quizImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    self.quizImageView.image = UIImage(named: "quizDefault.png")

                }
            }
        }
        
        
        
    }
    
    func addSubviews(){
        
        self.addSubview(quizImageView)
        self.addSubview(levelLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(titleLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
        
        quizImageView.clipsToBounds = true;
        quizImageView.contentMode = .scaleAspectFill;
        quizImageView.layer.cornerRadius = 10
        quizImageView.backgroundColor = .lightGray
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        
        levelLabel.textColor = .black
        levelLabel.font = UIFont.systemFont(ofSize: 20)
        
    }
    
    func positionSubviews(){
        
        quizImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizImageView.topAnchor.constraint(equalTo: self.topAnchor),
            quizImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            quizImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            quizImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            levelLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])

        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
    }
    
    
    
}
