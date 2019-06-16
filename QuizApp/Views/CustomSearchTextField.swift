//
//  CustomSearchTextField.swift
//  QuizApp
//
//  Created by five on 16/06/2019.
//  Copyright © 2019 five. All rights reserved.
//

import UIKit

class CustomSearchTextField: UITextField{
    
    var dataList : [Quiz] = [Quiz]()
    var resultsList : [Quiz] = [Quiz]()
    var tableView: UITableView?
    var currentText : String? = nil
    var selectedQuiz : Quiz? = nil
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()
        
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(CustomSearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
    }
    
    
    @objc open func textFieldDidChange(){
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidBeginEditing() {
    }
    
    
    @objc open func textFieldDidEndEditingOnExit() {
    }
    
    open func setItems(quizzes: [Quiz]) {
        dataList = quizzes
    }
    
    fileprivate func filter() {
        
        guard let searchString = self.text else {
            return
        }
        
        if searchString.count < 1 {
            resultsList = []
            return
        }
        resultsList = []
        resultsList = dataList.filter{ quiz in
            quiz.title.lowercased().starts(with: searchString.lowercased()) == true ||
            quiz.description?.lowercased().contains(searchString.lowercased()) == true
        }
        tableView?.reloadData()
    }
}

extension CustomSearchTextField: UITableViewDelegate, UITableViewDataSource {
    func buildSearchTableView() {
        if let tableView = tableView {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CustomSearchTextFieldCell")
            
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)
            
        } else {
            tableView = UITableView(frame: CGRect.zero)
        }
        
        updateSearchTableView()
    }
    
    func updateSearchTableView() {
        
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 10
            tableView.separatorStyle = .none
            tableView.backgroundColor = .white
            tableView.layer.cornerRadius = 10
            tableView.layer.shadowColor = UIColor.black.cgColor
            tableView.layer.shadowOffset = CGSize(width: 5, height: 5)
            tableView.layer.shadowRadius = 5
            tableView.layer.shadowOpacity = 0.2
            tableView.clipsToBounds = false
            tableView.layer.masksToBounds = false
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!

        if let cell = tableView.cellForRow(at: indexPath) as? QuizTableViewCell {
            cell.setup(with: resultsList[indexPath.row])
        } else {
            cell = QuizTableViewCell(with: resultsList[indexPath.row])
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.text = resultsList[indexPath.row].title
        self.selectedQuiz = resultsList[indexPath.row]
        tableView.isHidden = true
        
        self.endEditing(true)
    }
    
}


