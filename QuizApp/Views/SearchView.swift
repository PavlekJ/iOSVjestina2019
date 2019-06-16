//
//  SearchView.swift
//  iosProjekt
//
//  Created by five on 23/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView {
    
    let searchField = CustomSearchTextField(frame: CGRect(x: 0, y: 0, width: 300.00, height: 30.00))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func setupView(){
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }
    
    func addSubviews(){
        self.addSubview(searchField)
    }
    
    
    func styleSubviews(){
        searchField.placeholder = "Search"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 10
        searchField.setLeftPaddingPoints(10)
        searchField.layer.shadowColor = UIColor.black.cgColor
        searchField.layer.shadowOffset = CGSize(width: 5, height: 5)
        searchField.layer.shadowRadius = 5
        searchField.layer.shadowOpacity = 0.2
    }
    
    func positionSubviews(){
        searchField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchField.heightAnchor.constraint(equalToConstant: 45)
            ])
    }
}
