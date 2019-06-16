//
//  SearchViewController.swift
//  QuizApp
//
//  Created by five on 16/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController : UIViewController {
    
    var quizzes = [Quiz]()
    let searchView = SearchView()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(searchView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchView.topAnchor.constraint(equalTo: self.view.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        searchView.searchField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)

        loadQuizzes()
    }
    
    func loadQuizzes(){
        QuizService.shared.fetchQuizzes() { model in
            guard let quizzes = model else {
                return
            }
            self.searchView.searchField.setItems(quizzes: quizzes.quizzes)
        }
    }
    
    @objc
    func textFieldDidEndEditing() {
        print("bar ovo printaj")
        guard
            let quizName = searchView.searchField.text,
            let currentQuiz = searchView.searchField.selectedQuiz else {
                print("ovo nemoj ")
            return
        }
        
        print("ovo bi trebo")

        if currentQuiz.title == quizName {
            print("nece printat")
            let vc = ScrollableQuizViewController()
            vc.quiz = currentQuiz
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    
}
