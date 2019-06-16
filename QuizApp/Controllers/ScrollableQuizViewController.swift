//
//  ScrollableQuizViewController.swift
//  QuizApp
//
//  Created by five on 06/05/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class ScrollableQuizViewController: UIViewController {
    
    let scrollableQuizView = ScrollableQuizView()
    
    
    var quiz: Quiz? = nil
    var currentQuestionIndex = 0
    var startTime : TimeInterval? = nil
    var time: Double? = nil
    var correctAnswers = 0 { didSet {
        if quiz != nil {
            self.scrollableQuizView.answersLabel.text = "\(correctAnswers)/\(quiz!.questions.count)"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Play"
        setupView()
        scrollableQuizView.startButton.addTarget(self, action: #selector(startButtonTap), for: .touchUpInside)
        scrollableQuizView.sendButton.addTarget(self, action: #selector(sendResult), for: .touchUpInside)
        scrollableQuizView.backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        scrollableQuizView.rankButton.addTarget(self, action: #selector(rankButtonTap), for: .touchUpInside)
        
        guard let quizNew = quiz else {
            return
        }
        
        self.scrollableQuizView.customQuizView.setup(with: quizNew)

        
    }
    
    override func loadView() {
        self.view = ScrollableQuizView(frame: UIScreen.main.bounds)
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let quizNew = quiz else {
            return
        }
        
        self.scrollableQuizView.setupQuestions(with: quizNew)
        
        scrollableQuizView.questionViews.forEach{ questionView in
            questionView.answerButtons.forEach{ answerButton in
                answerButton.addTarget(self, action: #selector(answerButtonTap), for: .touchUpInside)
            }
            
        }
        
    }

    
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
    
    
    
    func setupView() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.addSubview(scrollableQuizView)
        
        scrollableQuizView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollableQuizView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollableQuizView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollableQuizView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollableQuizView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])

    }
    
    
    
    
    @objc
    func sendResult(){
        
        guard let quizId = self.quiz?.id else {
            return
        }
        guard let userId = UserDefaults.standard.object(forKey: "id") as? Int else {
            return
        }
        
        guard let time = self.time else {
            return
        }
        let result = Result(quizId: quizId, userId: userId, time: time, noOfCorrect: self.correctAnswers)

        QuizService.shared.sendQuizResult(result: result){ statusCode in
            
            DispatchQueue.main.async {
                if statusCode == nil{
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.statusLabel.text = "Something's wrong!"
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    return
                }
                
                switch statusCode {
                case 200:
                    self.scrollableQuizView.sendButton.alpha = 0.0
                    self.scrollableQuizView.backButton.alpha = 1.0
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.statusLabel.text = "Your result is sent!"
                    return
                case 400:
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    self.scrollableQuizView.statusLabel.text = "Something's bad, result was not sent"
                    return
                case 401:
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    self.scrollableQuizView.statusLabel.text = "Unauthorized, result was not sent"
                    return
                case 403:
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    self.scrollableQuizView.statusLabel.text = "Ovo će se pokazat"
                    return
                case 404:
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    self.scrollableQuizView.statusLabel.text = "This quiz doesn't exist"
                    return
                default:
                    self.scrollableQuizView.statusLabel.alpha = 1.0
                    self.scrollableQuizView.sendButton.setTitle("Send again", for: .normal)
                    self.scrollableQuizView.statusLabel.text = "Something's bad, result was not sent"
                    
                }
            }
        }
    }
    
    @objc
    func rankButtonTap(_ sender: UIButton){
        let vc = RankTableViewController()
        vc.quizId = quiz?.id
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(vc, animated: true)
        }
        

    }
    
    @objc
    func startButtonTap(_ sender: UIButton){
        
        startTime = Date().timeIntervalSinceReferenceDate
        UIView.animate(withDuration: 0.5) {
            self.scrollableQuizView.rankButton.alpha = 0.0
            self.scrollableQuizView.startButton.alpha = 0.0
            self.scrollableQuizView.questionsScrollView.alpha = 1.0
        }
    }
    
    @objc
    func backButtonTap(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func answerButtonTap(_ sender: UIButton){

        
        if sender.tag == self.quiz!.questions[currentQuestionIndex].correct_answer {
            self.correctAnswers += 1
            UIView.animate(withDuration: 0.4){
                sender.backgroundColor = UIColor.green
            }
        } else {
            UIView.animate(withDuration: 0.4){
                sender.backgroundColor = UIColor.red
            }
        }
        
        currentQuestionIndex += 1
        
        let current = scrollableQuizView.questionsScrollView.contentOffset
        UIView.animate(withDuration: 0.4, delay: 0.5, options:UIView.AnimationOptions.curveEaseInOut, animations: {
            self.scrollableQuizView.questionsScrollView.contentOffset = CGPoint(x: current.x+self.view.frame.width, y: 0)
        })
        
        if currentQuestionIndex == quiz?.questions.count {
            guard startTime != nil else {
                return
            }
            let time = Date().timeIntervalSinceReferenceDate - self.startTime!
            self.time = time
            let minutes : Int = Int(time) / 60
            let seconds = time - Double(minutes * 60)
            UIView.animate(withDuration: 0.4, delay: 0.5, options:UIView.AnimationOptions.curveEaseInOut, animations: {
                self.scrollableQuizView.questionsScrollView.alpha = 0.0
                self.scrollableQuizView.answersLabel.alpha = 1.0
                self.scrollableQuizView.sendButton.alpha = 1.0
                self.scrollableQuizView.timeLabel.alpha = 1.0
                self.scrollableQuizView.timeLabel.text = "\(minutes):\(round(seconds*100)/100)"
            })
        }
    }
    
    
    
    
    
    
        
}
