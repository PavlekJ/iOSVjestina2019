//
//  SettingsView.swift
//  QuizApp
//
//  Created by five on 14/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SettingsView : UIView {
    
    let nameLabel = UILabel()
    let logoutButton = UIButton()
    
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
        self.addSubview(logoutButton)
        self.addSubview(nameLabel)
    }
    func styleSubviews(){
        
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        
        logoutButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.layer.shadowColor = UIColor.black.cgColor
        logoutButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoutButton.layer.shadowRadius = 5
        logoutButton.layer.shadowOpacity = 0.2
        logoutButton.layer.cornerRadius = 10
    }
    
    func positionSubviews(){
        
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100)
            ])
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            logoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -80),
            logoutButton.heightAnchor.constraint(equalToConstant: 45)])
    }
    
    
    
    
    
    
    
}
