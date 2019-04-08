//
//  QuizViewController.swift
//  QuizApp
//
//  Created by five on 02/04/2019.
//  Copyright © 2019 five. All rights reserved.
//

import Foundation
import UIKit

class QuizViewController: UIViewController {
    
    let quizView = QuizView()
    var quizzes: Quizzes? = nil
    var question: Question? = nil
    var customQuestionView = CustomQuestionView()
    var quizId: Int? = nil
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
            
        }
    }
    
    override func loadView() {
        self.view = QuizView(frame: UIScreen.main.bounds)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(quizView)
        
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            quizView.topAnchor.constraint(equalTo: self.view.topAnchor),
            quizView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        quizView.loadButton.addTarget(self, action: #selector(loadQuizzes), for: .touchUpInside)
        quizView.loadButton.addTarget(self, action: #selector(touchButton), for: .touchDown)
        quizView.funFactButton.addTarget(self, action: #selector(LogOutAction), for: .touchUpInside)
        quizView.funFactButton.addTarget(self, action: #selector(touchButton), for: .touchDown)


    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @objc
    func touchButton(_ sender : UIButton){
        sender.backgroundColor = UIColor(red:0.75, green:0.38, blue:0.60, alpha:1.0)
        sender.layer.shadowOpacity = 0
    }
    
    @objc
    func loadQuizzes(){
        self.quizView.loadButton.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        self.quizView.loadButton.layer.shadowOpacity = 0.2
        QuizService.shared.fetchQuizzes() { model in
            guard let quizzes = model else {
                DispatchQueue.main.async {
                    self.quizView.errorLabel.isHidden = false
                }
                return
            }
            self.quizzes = quizzes
            
            DispatchQueue.main.async {
                let numNBAMentioned = quizzes.quizzes.map{ (quiz:Quiz) -> [Question] in
                    return quiz.questions.filter { (question) -> Bool in
                        return question.question.contains("NBA")
                    }
                }.count
                
                self.quizView.funFactButton.setTitle("NBA mentioned in \(numNBAMentioned) questions!", for: .normal)
                self.quizView.loadButton.isHidden = true
                self.quizView.funFactButton.isHidden = false
                self.addQuizzes(quizzes: quizzes)
                self.quizView.errorLabel.isHidden = true
            }
        }
    }
    
    func addQuizzes(quizzes: Quizzes){
        let customQuizView = CustomQuizView()
        
        let randomInt = Int.random(in: 0..<quizzes.quizzes.count)
        self.quizId = randomInt
        let imageUrl = quizzes.quizzes[randomInt].image
        
        QuizService.shared.fetchQuizImage(imageUrl: imageUrl){ (image) in
            if image != nil {
            DispatchQueue.main.async {
                customQuizView.quizImageView.image = image
                }
            } else {
                DispatchQueue.main.async {
                    customQuizView.quizImageView.image = UIImage(named: "quizDefault.png")
                }

            }
        }
        
        
        
        customQuizView.titleLabel.text = quizzes.quizzes[randomInt].title
        customQuizView.categoryLabel.text = quizzes.quizzes[randomInt].category
        customQuizView.descriptionLabel.text = quizzes.quizzes[randomInt].description
        customQuizView.levelLabel.text = "Level: \(quizzes.quizzes[randomInt].level)"
        customQuizView.categoryLabel.backgroundColor = quizzes.quizzes[randomInt].categoryColor()
        customQuizView.categoryLabel.layer.borderColor = quizzes.quizzes[randomInt].categoryColor().cgColor
        
        customQuizView.layer.shadowColor = UIColor.black.cgColor
        customQuizView.layer.shadowOffset = CGSize(width: 5, height: 5)
        customQuizView.layer.shadowRadius = 5
        customQuizView.layer.shadowOpacity = 0.2
        customQuizView.layer.cornerRadius = 10
        customQuizView.backgroundColor = .white
        
        customQuizView.alpha = 0.0
        
        
        let randomQuestionInt = Int.random(in: 0..<quizzes.quizzes[randomInt].questions.count)
        let question = quizzes.quizzes[randomInt].questions[randomQuestionInt]
        self.question = question
        let customQuestionView = CustomQuestionView()
        
        self.customQuestionView = customQuestionView
        customQuestionView.questionLabel.text = question.question
        customQuestionView.answerButton1.setTitle(question.answers[0], for: .normal)
        customQuestionView.answerButton2.setTitle(question.answers[1], for: .normal)
        customQuestionView.answerButton3.setTitle(question.answers[2], for: .normal)
        customQuestionView.answerButton4.setTitle(question.answers[3], for: .normal)

        
        
        customQuestionView.layer.shadowColor = UIColor.black.cgColor
        customQuestionView.layer.shadowOffset = CGSize(width: 5, height: 5)
        customQuestionView.layer.shadowRadius = 5
        customQuestionView.layer.shadowOpacity = 0.2
        customQuestionView.layer.cornerRadius = 10
        customQuestionView.backgroundColor = .white
        customQuestionView.alpha = 0.0
        
        
        
        self.view.addSubview(customQuestionView)
        
        customQuestionView.answerButton1.addTarget(self, action: #selector(answerButtonTap), for: .touchUpInside)
        customQuestionView.answerButton2.addTarget(self, action: #selector(answerButtonTap), for: .touchUpInside)
        customQuestionView.answerButton3.addTarget(self, action: #selector(answerButtonTap), for: .touchUpInside)
        customQuestionView.answerButton4.addTarget(self, action: #selector(answerButtonTap), for: .touchUpInside)

        
        
        
        
        customQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customQuestionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            customQuestionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customQuestionView.heightAnchor.constraint(equalToConstant: 280)
            ])
        



        
        self.view.addSubview(customQuizView)
        
        
        customQuizView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customQuizView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            customQuizView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            customQuizView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 110)
            ])
        
        if #available(iOS 11.0, *) {
            customQuizView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -330).isActive = true
            
            customQuestionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        } else {
            customQuizView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -330).isActive = true
            customQuestionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        }
        
        UIView.animate(withDuration: 0.5) {
            customQuizView.alpha = 1.0
            customQuestionView.alpha = 1.0
            customQuestionView.answerButton1.transform = CGAffineTransform(translationX: 0, y: -160)
            customQuestionView.answerButton2.transform = CGAffineTransform(translationX: 0, y: -110)
            customQuestionView.answerButton3.transform = CGAffineTransform(translationX: 0, y: -60)
            customQuestionView.answerButton4.transform = CGAffineTransform(translationX: 0, y: -10)


        }
        
    }
    
    
    @objc
    func answerButtonTap(_ sender: UIButton){
        
        self.customQuestionView.answerButtons.forEach{ button in
            button.isEnabled = false
        }
        
        if sender.tag == self.question?.correct_answer {
            
            UIView.animate(withDuration: 0.8){
                sender.backgroundColor = UIColor.green
            }
        } else {
            UIView.animate(withDuration: 0.8){
                sender.backgroundColor = UIColor.red
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.changeQuestion()
        }
        
        
    }
    
    @objc
    func changeQuestion(){
        let randomQuestionInt = Int.random(in: 0..<self.quizzes!.quizzes[self.quizId!].questions.count)
        let question = self.quizzes?.quizzes[self.quizId!].questions[randomQuestionInt]
        self.question = question
        
        self.customQuestionView.questionLabel.text = question?.question
        self.customQuestionView.answerButton1.setTitle(question?.answers[0], for: .normal)
        self.customQuestionView.answerButton2.setTitle(question?.answers[1], for: .normal)
        self.customQuestionView.answerButton3.setTitle(question?.answers[2], for: .normal)
        self.customQuestionView.answerButton4.setTitle(question?.answers[3], for: .normal)
        
        self.customQuestionView.answerButtons.forEach{ button in
            button.isEnabled = true
            button.backgroundColor = UIColor(red:0.66, green:0.66, blue:0.66, alpha:1.0)
        }
        
    }
    
    @objc
    func LogOutAction(_ sender: UIButton){
        sender.backgroundColor = UIColor(red:0.81, green:0.44, blue:0.66, alpha:1.0)
        sender.layer.shadowOpacity = 0.2
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
