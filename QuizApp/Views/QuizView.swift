//
//  QuizView.swift
//  QuizApp
//
//  Created by five on 02/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizView: UIView {
    let loadButton = UIButton()
    let funFactButton = UIButton()
    let errorLabel = UILabel()
    
    
    
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
    
    func addSubviews() {
        self.addSubview(loadButton)
        self.addSubview(funFactButton)
        self.addSubview(errorLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white
        
        loadButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        loadButton.setTitleColor(.white, for: .normal)
        loadButton.setTitle("Load", for: .normal)
        loadButton.layer.shadowColor = UIColor.black.cgColor
        loadButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loadButton.layer.shadowRadius = 5
        loadButton.layer.shadowOpacity = 0.2
        loadButton.layer.cornerRadius = 5
        loadButton.isEnabled = true
        
        funFactButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        funFactButton.setTitleColor(.white, for: .normal)
        funFactButton.setTitle("Fun fact", for: .normal)
        funFactButton.layer.shadowColor = UIColor.black.cgColor
        funFactButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        funFactButton.layer.shadowRadius = 5
        funFactButton.layer.shadowOpacity = 0.2
        funFactButton.layer.cornerRadius = 5
        funFactButton.isHidden = true
        
        errorLabel.textColor = .black
        errorLabel.text = "Unfortunately, there was an error. Check your internet connection"
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        

        
        
        
    }
    
    func positionSubviews(){
        
        loadButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            loadButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadButton.heightAnchor.constraint(equalToConstant: 45),
            loadButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])

        
        
        
        funFactButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            funFactButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            funFactButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            funFactButton.heightAnchor.constraint(equalToConstant: 45),
            funFactButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
            ])
        
    }
    
}
