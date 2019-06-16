//
//  SettingsViewController.swift
//  QuizApp
//
//  Created by five on 14/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    
    let settingsView = SettingsView()
    let logoutController = UIAlertController(title: "Log out", message: "Do you want to log out?", preferredStyle: .alert)

    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(settingsView)
        
        self.title = "Settings"
        self.view.backgroundColor = .white
        
        
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            settingsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            settingsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        settingsView.logoutButton.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
        
        setupView()
    }
    
    func setupView(){
        guard let name = UserDefaults.standard.object(forKey: "username") as! String? else {
            return
        }
        
        let cancelAction = UIAlertAction(title: "Log out", style: .default, handler: logout)
        let logoutAction = UIAlertAction(title: "Cancel", style: .cancel)
        logoutController.addAction(logoutAction)
        logoutController.addAction(cancelAction)
        
        self.settingsView.nameLabel.text = "Username: \(name)"
    }
    
    @objc
    func logoutButtonTap(_ sender: UIButton){
        self.present(logoutController, animated: true, completion: nil)
    }
    
    
    func logout(_ action: UIAlertAction){
        DispatchQueue.main.async {
            self.navigationController?.tabBarController?.dismiss(animated: true)
        }
        UserDefaults.standard.set(nil, forKey: "token")
    }
    
    
}
