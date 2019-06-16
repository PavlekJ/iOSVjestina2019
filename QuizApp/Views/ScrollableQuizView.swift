//
//  ScrollableQuizView.swift
//  QuizApp
//
//  Created by five on 06/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit


class ScrollableQuizView: UIView {
    
    
    let customQuizView = CustomQuizView()
    let startButton = UIButton()
    let questionsScrollView = UIScrollView()
    var questionViews : [CustomQuestionView] = []
    let answersLabel = UILabel()
    let timeLabel = UILabel()
    let sendButton = UIButton()
    let statusLabel = UILabel()
    let backButton = UIButton()
    let rankButton = UIButton()
    var setUp = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    func setupQuestions(with quiz: Quiz){
        
        if setUp == false{
            let width = self.frame.size.width
            var length: CGFloat = 0.0
            
            self.questionsScrollView.contentSize.width = CGFloat(quiz.questions.count) * width
            
            answersLabel.text = "0/\(quiz.questions.count)"
            
            
            quiz.questions.forEach{question in
                let questionView = CustomQuestionView()
                questionView.setup(with: question)

                questionViews.append(questionView)
                
                questionView.layer.shadowColor = UIColor.black.cgColor
                questionView.layer.shadowOffset = CGSize(width: 5, height: 5)
                questionView.layer.shadowRadius = 5
                questionView.layer.shadowOpacity = 0.2
                questionView.layer.cornerRadius = 10
                questionView.backgroundColor = .white


                questionsScrollView.addSubview(questionView)
                questionView.frame = CGRect(x: 0, y: 0, width: questionsScrollView.frame.width * 0.85, height: questionsScrollView.frame.height * 0.9)
                
                questionView.center.x = questionsScrollView.center.x
                questionView.transform = CGAffineTransform(translationX: length, y: 0)

                length = length + width
                setUp = true
            }
        }
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Has to be implemented as it is required but will never be used")
    }
    
    func setupView(){
        self.addSubviews()
        self.styleSubviews()
        self.positionSubviews()
    }
    
    func addSubviews() {
        self.addSubview(customQuizView)
        self.addSubview(startButton)
        self.addSubview(questionsScrollView)
        self.addSubview(answersLabel)
        self.addSubview(timeLabel)
        self.addSubview(sendButton)
        self.addSubview(statusLabel)
        self.addSubview(backButton)
        self.addSubview(rankButton)
    }
    
    
    func styleSubviews() {
        self.backgroundColor = .white
        
        customQuizView.layer.shadowColor = UIColor.black.cgColor
        customQuizView.layer.shadowOffset = CGSize(width: 5, height: 5)
        customQuizView.layer.shadowRadius = 5
        customQuizView.layer.shadowOpacity = 0.2
        customQuizView.layer.cornerRadius = 10
        customQuizView.backgroundColor = .white

        startButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("Start!", for: .normal)
        startButton.layer.shadowColor = UIColor.black.cgColor
        startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        startButton.layer.shadowRadius = 5
        startButton.layer.shadowOpacity = 0.2
        startButton.layer.cornerRadius = 10
        
        questionsScrollView.alpha = 0.0
        questionsScrollView.isScrollEnabled = false
        
        
        answersLabel.alpha = 0.0
        answersLabel.text = "NaN"
        answersLabel.font = UIFont.systemFont(ofSize: 90)
        
        timeLabel.alpha = 0.0
        timeLabel.font = UIFont.systemFont(ofSize: 30)
        
        sendButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.setTitle("Send result", for: .normal)
        sendButton.layer.shadowColor = UIColor.black.cgColor
        sendButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        sendButton.layer.shadowRadius = 5
        sendButton.layer.shadowOpacity = 0.2
        sendButton.layer.cornerRadius = 10
        sendButton.alpha = 0.0
        
        statusLabel.alpha = 0.0
        statusLabel.font = UIFont.systemFont(ofSize: 15)
        
        backButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.layer.shadowColor = UIColor.black.cgColor
        backButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        backButton.layer.shadowRadius = 5
        backButton.layer.shadowOpacity = 0.2
        backButton.layer.cornerRadius = 10
        backButton.alpha = 0.0
        
        rankButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        rankButton.setTitleColor(.white, for: .normal)
        rankButton.setTitle("Best players", for: .normal)
        rankButton.layer.shadowColor = UIColor.black.cgColor
        rankButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        rankButton.layer.shadowRadius = 5
        rankButton.layer.shadowOpacity = 0.2
        rankButton.layer.cornerRadius = 10
        rankButton.alpha = 1.0
        
        
    }
    
    func positionSubviews() {
        customQuizView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customQuizView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            customQuizView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            customQuizView.topAnchor.constraint(equalTo: self.topAnchor, constant: 70),
            customQuizView.heightAnchor.constraint(equalToConstant: 250)
            ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 45),
            startButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 335)
            ])
        
        rankButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            rankButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            rankButton.heightAnchor.constraint(equalToConstant: 45),
            rankButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 390)
            ])
        
        questionsScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionsScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 335),
            questionsScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            questionsScrollView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0),
            questionsScrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor)])
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sendButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sendButton.heightAnchor.constraint(equalToConstant: 45),
            sendButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
            ])
        
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answersLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -130),
            answersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
    
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -230),
            timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            statusLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            ])
        
        
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 45),
            backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
            ])
    }
    
}
