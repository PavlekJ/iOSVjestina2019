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
            let loginViewController = LoginViewController()
            window.rootViewController = loginViewController
            window.makeKeyAndVisible()

            if isUserLoggedIn() {
                let mainTabBarController = MainTabBarController()
                loginViewController.present(mainTabBarController, animated: false)
            }
        }
        return true
        
    }
    
    func isUserLoggedIn() -> Bool {
        return !(UserDefaults.standard.object(forKey: "token") == nil)
    }

}


