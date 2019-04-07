//
//  CustomQuizView.swift
//  QuizApp
//
//  Created by five on 03/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit


class CustomQuizView: UIView{
    
    let quizImageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    let levelLabel = UILabel()
    let descriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
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
        
        self.addSubview(quizImageView)
        self.addSubview(categoryLabel)
        self.addSubview(levelLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(titleLabel)
    }
    
    func styleSubviews(){
        
        quizImageView.clipsToBounds = true;
        quizImageView.contentMode = .scaleAspectFill;
        quizImageView.layer.cornerRadius = 10
        
        categoryLabel.textColor = .white
        categoryLabel.font = UIFont.systemFont(ofSize: 10)
        
        

        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        
        levelLabel.textColor = .black
        levelLabel.font = UIFont.systemFont(ofSize: 10)
        
    }
    
    func positionSubviews(){
        
        quizImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizImageView.topAnchor.constraint(equalTo: self.topAnchor),
            quizImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            quizImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            quizImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
        
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            levelLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            levelLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
    }





    
    
    
    
}
