//
//  RankTableViewController.swift
//  QuizApp
//
//  Created by five on 17/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class RankTableViewController: UIViewController {
    let tableView = UITableView()
    var quizId: Int? = nil
    
    private var ranks: [Rank]? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadRanks()
        self.title = "Rank"
        self.setupView()
        }
    

    func setupView(){
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
        tableView.separatorStyle = .singleLine
        
    }
    
    func loadRanks(){
        guard let id = quizId else {
            return
        }
        
        QuizService.shared.fetchRank(quizId: id) {model in
            guard let ranks = model else {
                return
            }
            self.ranks = ranks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension RankTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let ranks = ranks else{
            return 0
        }
        
        return ranks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let ranks = ranks else{
            return UITableViewCell()
        }
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        let nameLabel = UILabel()
        
        cell.addSubview(nameLabel)
        nameLabel.text = ranks[indexPath.row].username
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 50)])
        
        let scoreLabel = UILabel()
        
        cell.addSubview(scoreLabel)
        
        let string = ranks[indexPath.row].score.components(separatedBy: ".")
        scoreLabel.text = string.first
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -30)])
        
        
        let rankLabel = UILabel()
        cell.addSubview(rankLabel)
        rankLabel.text = "\(indexPath.row+1)."
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 15)])
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}


extension RankTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = UIView()
        sectionHeaderView.alpha = 1
        let userLabel = UILabel()
        let scoreLabel = UILabel()
        sectionHeaderView.addSubview(userLabel)
        sectionHeaderView.addSubview(scoreLabel)
        userLabel.text = "User"
        scoreLabel.text = "Score"
        sectionHeaderView.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        userLabel.textColor = .white
        userLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userLabel.leadingAnchor.constraint(equalTo: sectionHeaderView.leadingAnchor, constant: 50),
            userLabel.centerYAnchor.constraint(equalTo: sectionHeaderView.centerYAnchor)
            ])
        scoreLabel.textColor = .white
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(equalTo: sectionHeaderView.trailingAnchor, constant: -30),
            scoreLabel.centerYAnchor.constraint(equalTo: sectionHeaderView.centerYAnchor)
            ])
        
        
        
        
        
        return sectionHeaderView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    
    
}
