//
//  AppDelegate.swift
//  QuizApp
//
//  Created by five on 02/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?




    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        UINavigationBar.appearance().tintColor = .black
        
        if let window = window {
            if isUserLoggedIn() {
                let mainVC = QuizTableViewController()
                navigationController = UINavigationController(rootViewController: mainVC)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            } else {
                let mainVC = LoginViewController()
                navigationController = UINavigationController(rootViewController: mainVC)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
        
        return true
        
    }
    
    func isUserLoggedIn() -> Bool {
        return !(UserDefaults.standard.object(forKey: "token") == nil)
    }

}


