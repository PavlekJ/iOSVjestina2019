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
        self.addSubview(categoryLabel)
        self.addSubview(levelLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(titleLabel)
    }
    
    func styleSubviews(){
        categoryLabel.textColor = .black
        categoryLabel.font = UIFont.systemFont(ofSize: 10)

        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 10)
        
        levelLabel.textColor = .black
        levelLabel.font = UIFont.systemFont(ofSize: 10)
        
    }
    
    func positionSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
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
