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



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = QuizViewController()
        
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        return true
    }
}

