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
        self.title = "Log in"
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
        loginView.titleLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)

        DispatchQueue.main.async {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: [ .curveEaseInOut ],
                           animations: {
                            self.loginView.titleLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
                            },
                           completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bringElements()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeElements()
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
            UserDefaults.standard.set(token.token, forKey: "token")
            UserDefaults.standard.set(token.id, forKey: "id")
            DispatchQueue.main.async {
                UserDefaults.standard.set(self.loginView.nameField.text, forKey: "username")
                
                self.loginView.errorLabel.isHidden = true
                let tabBarController = MainTabBarController()
                
                DispatchQueue.main.async {
                    self.loginView.nameFieldConstraint?.constant = 400
                    UIView.animate(withDuration: 0.4, animations: {
                        self.view.layoutIfNeeded()
                    }) { bool in
                        self.loginView.passwordFieldConstraint?.constant = 400
                        UIView.animate(withDuration: 0.4, animations: {
                            self.view.layoutIfNeeded()
                        }) { bool in
                            self.loginView.loginButtonConstraint?.constant = 400
                            UIView.animate(withDuration: 0.4, animations: {
                                self.view.layoutIfNeeded()
                            }) { bool in
                                self.present(tabBarController, animated: true)
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func bringElements() {
        DispatchQueue.main.async {
            self.loginView.nameFieldConstraint?.constant = 0
            UIView.animate(withDuration: 0.4, animations: {
                self.view.layoutIfNeeded()
            }) { bool in
                self.loginView.passwordFieldConstraint?.constant = 0
                UIView.animate(withDuration: 0.4, animations: {
                    self.view.layoutIfNeeded()
                }) { boolean in
                    self.loginView.loginButtonConstraint?.constant = 0
                    UIView.animate(withDuration: 0.4) {
                        self.view.layoutIfNeeded()
                        
                    }
                }
            }
        }
    }
    
    func removeElements() {
        self.loginView.nameFieldConstraint?.constant = -400
        self.loginView.passwordFieldConstraint?.constant = -400
        self.loginView.loginButtonConstraint?.constant = -400
        
    }
}
