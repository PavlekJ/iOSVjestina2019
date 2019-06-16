//
//  MainTabBarController.swift
//  QuizApp
//
//  Created by five on 14/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        
        
        //TODO: find appropriate icons
        let quizTableViewController = QuizTableViewController()
        let tableNavigationController = UINavigationController(rootViewController: quizTableViewController)
        tableNavigationController.tabBarItem = UITabBarItem(title: "Quizzes", image: UIImage(named: "quizzes"), selectedImage: UIImage(named: "quizzes"))
        
        
        let searchViewController = SearchViewController()
        let searchNavigationViewController = UINavigationController(rootViewController: searchViewController)
        searchNavigationViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), selectedImage: UIImage(named: "search"))
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationViewController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), selectedImage: UIImage(named: "settings"))
        
        let tabBarList = [tableNavigationController, searchNavigationViewController, settingsNavigationViewController]
        viewControllers = tabBarList
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tabBar.tintColor = .black

    }
}
