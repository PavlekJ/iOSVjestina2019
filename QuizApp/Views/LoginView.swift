//
//  LoginView.swift
//  QuizApp
//
//  Created by five on 08/04/2019.
//  Copyright © 2019 five. All rights reserved.
//
import UIKit
import Foundation


class LoginView: UIView{
    
    let nameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let loginButton = UIButton()
    
    
    
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
        self.addSubview(nameField)
        self.addSubview(passwordField)
        self.addSubview(loginButton)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white

        
        nameField.placeholder = "Name"
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        nameField.layer.cornerRadius = 5
        nameField.setLeftPaddingPoints(10)
        
        
        passwordField.placeholder = "Password"
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.cornerRadius = 5
        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(10)
        
        
        loginButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.cornerRadius = 5
        
        
    }
    
    func positionSubviews(){
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            passwordField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        
        
        
    }
    
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
