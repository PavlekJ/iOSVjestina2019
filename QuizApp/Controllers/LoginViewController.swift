//
//  LoginViewController.swift
//  QuizApp
//
//  Created by five on 08/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController{
    let loginView = LoginView()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
            
        }
    }
    
    override func loadView() {
        self.view = LoginView(frame: UIScreen.main.bounds)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(loginView)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        loginView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        loginView.loginButton.addTarget(self, action: #selector(openQuizView), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(touchButton), for: .touchDown)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc
    func touchButton(_ sender : UIButton){
        
        sender.backgroundColor = UIColor(red:0.75, green:0.38, blue:0.60, alpha:1.0)
        sender.layer.shadowOpacity = 0
        
    }
    
    
    @objc
    func openQuizView(_ sender : UIButton){
        sender.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        sender.layer.shadowOpacity = 0.2
        
        guard let username = self.loginView.nameField.text else {
            return
        }
        guard let password = self.loginView.passwordField.text else {
            return
        }
        
        LoginService.shared.fetchToken(username: username, password: password) {model in
            guard let token = model else {
                DispatchQueue.main.async {
                    self.loginView.errorLabel.isHidden = false
                }
                return
            }
            UserDefaults.standard.set(token.token, forKey:"token")
            DispatchQueue.main.async {
                self.loginView.errorLabel.isHidden = true
                let quizViewController = QuizViewController()
                self.dismiss(animated: true, completion: nil)
                self.present(quizViewController, animated: true, completion: nil)
                
            }
            
        }
        
        
        
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
