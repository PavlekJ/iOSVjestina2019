//
//  QuizTableViewController.swift
//  QuizApp
//
//  Created by five on 05/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizTableViewController: UIViewController {
    
    
    private var quizzes = [Quiz]()
    let tableView = UITableView()
    let logoutController = UIAlertController(title: "Log out", message: "Do you want to log out?", preferredStyle: .alert)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Quizzes"
        loadQuizzes()
        sleep(2)
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func loadQuizzes(){
        QuizService.shared.fetchQuizzes() { model in
            guard let quizzes = model else {
                return
            }
            self.quizzes = quizzes.quizzes
        }
    }
    
    
    func setupView() {
        
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        self.navigationItem.hidesBackButton = true
        
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width:self.view.frame.width , height: 80))
        let logoutButton = UIButton()
        
        logoutButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.layer.shadowColor = UIColor.black.cgColor
        logoutButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        logoutButton.layer.shadowRadius = 5
        logoutButton.layer.shadowOpacity = 0.2
        logoutButton.layer.cornerRadius = 10
        logoutButton.isEnabled = true
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            logoutButton.widthAnchor.constraint(equalTo: footerView.widthAnchor, multiplier: 0.85),
            logoutButton.heightAnchor.constraint(equalToConstant: 45)])
        
        
        tableView.tableFooterView = footerView
        
        let leadingTableView = tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        leadingTableView.priority = UILayoutPriority.defaultLow
        let trailingTableView = tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        trailingTableView.priority = UILayoutPriority.defaultLow
        let topTableView = tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 24)
        topTableView.priority = UILayoutPriority.defaultLow
        let bottomTableView = tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        bottomTableView.priority = UILayoutPriority.defaultLow
        
        NSLayoutConstraint.activate([
            leadingTableView,
            trailingTableView,
            topTableView,
            bottomTableView
            ])
        
        tableView.register(QuizTableViewCell.self, forCellReuseIdentifier: QuizTableViewCell.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        let cancelAction = UIAlertAction(title: "Log out", style: .default, handler: logout)
        let logoutAction = UIAlertAction(title: "Cancel", style: .cancel)
        logoutController.addAction(logoutAction)
        logoutController.addAction(cancelAction)
    }
    
    @objc
    func logoutButtonTap(_ sender: UIButton){
        self.present(logoutController, animated: true, completion: nil)
    }
    
    
    func logout(_ action: UIAlertAction){
        DispatchQueue.main.async {
            if self.navigationController?.viewControllers.first == self {
                let loginViewController = LoginViewController()
                self.navigationController?.viewControllers = [loginViewController] + self.navigationController!.viewControllers
            }
            self.navigationController?.popViewController(animated: true)
        }
        
        UserDefaults.standard.set(nil, forKey: "token")
    }
    
}

extension QuizTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        return Array(Set(categories)).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        let uniqueCategories = Array(Set(categories)).sorted()
        
        return quizzes.filter{ quiz in
            quiz.category == uniqueCategories[section]
            }.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        let category = Array(Set(categories)).sorted()[indexPath.section]
        let quizzesFiltered = quizzes.filter{ quiz in
            quiz.category == category
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? QuizTableViewCell {
            cell.setup(with: quizzesFiltered[indexPath.row])
        } else {
            cell = QuizTableViewCell(with: quizzesFiltered[indexPath.row])
        }
        
        return cell

    }
    
    
}


extension QuizTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? QuizTableViewCell else
        {
            return
        }
        
        let vc = ScrollableQuizViewController()
        vc.quiz = cell.quiz
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        let uniqueCategories = Array(Set(categories)).sorted()

        let sectionHeaderView = UIView()
        sectionHeaderView.alpha = 1
        let categoryLabel = UILabel()
        sectionHeaderView.addSubview(categoryLabel)
        categoryLabel.text = uniqueCategories[section]
        sectionHeaderView.backgroundColor = uniqueCategories[section].categoryColor()
        categoryLabel.textColor = .white
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: sectionHeaderView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: sectionHeaderView.centerYAnchor)
            ])
        
        

        
        
        return sectionHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let categories = quizzes.map{ quiz  in
            return quiz.category
        }
        let uniqueCategories = Array(Set(categories)).sorted()
        return uniqueCategories[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footerView = UIView(frame: CGRect(x: 100, y:0, width: self.view.frame.width, height: 60))
//
    
//
//
//        footerView.addSubview(logoutButton)
//
//        let widthConstraint = NSLayoutConstraint(item: logoutButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tableView.frame.width)
//        let heightConstraint = NSLayoutConstraint(item: logoutButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
//
//
//        logoutButton.addConstraints([widthConstraint, heightConstraint])
//        return footerView
//    }
    

}

extension String{
    func categoryColor() -> UIColor {
        switch self {
        case "SPORTS":
            return UIColor(red:0.1, green:0.54, blue:0.1, alpha:1.0)
        case "SCIENCE":
            return UIColor(red:0.1, green:0.1, blue:0.54, alpha:1.0)
        default:
            return UIColor(red:0.54, green:0.1, blue:0.1, alpha:1.0)
        }
    }
}
