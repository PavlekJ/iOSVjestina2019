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
    
    
    let titleLabel = UILabel()
    let nameField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let passwordField = UITextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    let loginButton = UIButton()
    let errorLabel = UILabel()
    
    var titleConstraint : NSLayoutConstraint? = nil
    var nameFieldConstraint : NSLayoutConstraint? = nil
    var passwordFieldConstraint : NSLayoutConstraint? = nil
    var loginButtonConstraint : NSLayoutConstraint? = nil
    
    
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
        self.addSubview(errorLabel)
        self.addSubview(titleLabel)
    }
    
    func styleSubviews(){
        self.backgroundColor = .white

        titleLabel.text = "QuizApp"
        titleLabel.font = UIFont(name: "Zapfino", size: 20)
        titleLabel.textColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        
        nameField.placeholder = "Name"
        nameField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        nameField.layer.cornerRadius = 10
        nameField.setLeftPaddingPoints(10)
        
        
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        passwordField.layer.cornerRadius = 10
        passwordField.isSecureTextEntry = true
        passwordField.setLeftPaddingPoints(10)
        
        
        loginButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 0.2
        loginButton.layer.cornerRadius = 10
        
        errorLabel.textColor = .black
        errorLabel.text = "Username or password incorrect"
        errorLabel.isHidden = true
        errorLabel.numberOfLines = 0
        errorLabel.lineBreakMode = .byWordWrapping
        
        
    }
    
    func positionSubviews(){
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)])
        
        nameFieldConstraint = nameField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -400)

        nameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            nameFieldConstraint!,
            nameField.heightAnchor.constraint(equalToConstant: 35),
            nameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        passwordFieldConstraint = passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -400)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordField.topAnchor.constraint(equalTo: self.topAnchor, constant: 150),
            passwordFieldConstraint!,
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            passwordField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        loginButtonConstraint =  loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -400)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 200),
            loginButtonConstraint!,
            loginButton.heightAnchor.constraint(equalToConstant: 45),
            loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85)
            ])
        
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 250),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
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
