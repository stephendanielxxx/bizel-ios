//
//  ActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 16/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ActionViewController: UIViewController {
    
    var moduleTitle = ""
    var topicId = ""
    var actionId = ""
    let URL = "\(DigilearnParams.ApiUrl)/quiz/get_quiz_course"
    var assesmentModel: AssesmentModel!
    var indexPage = 0
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var embedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.title = moduleTitle
        
        loadData()
        
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        let parameters: [String:Any] = [
            "topic_id": "\(self.topicId)",
            "action_id" : "\(self.actionId)"
        ]
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.assesmentModel = try decoder.decode(AssesmentModel.self, from:data)
                            
                            let quiz = QuizViewController()
                            quiz.delegate = self
                            quiz.topicId = self.topicId
                            quiz.actionId = self.actionId
                            quiz.quiz = self.assesmentModel.assessmentQuiz![self.indexPage]
                            quiz.index = self.indexPage
                            quiz.modalPresentationStyle = .fullScreen
                            
                            self.embed(quiz, inParent: self, inView: self.embedView)
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    default:
                        self.removeSpinner()
                    }
        }
    }
}

extension ActionViewController: QuizDelegate{
    func nextAction(index: Int) {
        self.indexPage = index + 1
        
        let assesmentQuiz = self.assesmentModel.assessmentQuiz![indexPage]
        
        if assesmentQuiz.category?.caseInsensitiveCompare("quiz") == .orderedSame {
            if assesmentQuiz.quizType?.caseInsensitiveCompare("single") == .orderedSame {
                let quiz = QuizViewController()
                quiz.delegate = self
                quiz.topicId = self.topicId
                quiz.actionId = self.actionId
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }else if assesmentQuiz.quizType?.caseInsensitiveCompare("essay") == .orderedSame {
                let quiz = QuizEssayViewController()
                quiz.delegate = self
                quiz.topicId = self.topicId
                quiz.actionId = self.actionId
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }
        }else if assesmentQuiz.category?.caseInsensitiveCompare("material") == .orderedSame{
            let material = MaterialViewController()
            material.delegate = self
            material.topicId = self.topicId
            material.actionId = self.actionId
            material.index = self.indexPage
            material.quiz = assesmentQuiz
            material.modalPresentationStyle = .fullScreen
            
            self.embed(material, inParent: self, inView: self.embedView)
        }
        
        
    }
    
    func prevAction(index: Int) {
        self.indexPage = index - 1
        
        let assesmentQuiz = self.assesmentModel.assessmentQuiz![indexPage]
        
        if assesmentQuiz.category?.caseInsensitiveCompare("quiz") == .orderedSame {
            if assesmentQuiz.quizType?.caseInsensitiveCompare("single") == .orderedSame {
                let quiz = QuizViewController()
                quiz.delegate = self
                quiz.topicId = self.topicId
                quiz.actionId = self.actionId
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }else if assesmentQuiz.quizType?.caseInsensitiveCompare("essay") == .orderedSame {
                let quiz = QuizEssayViewController()
                quiz.delegate = self
                quiz.topicId = self.topicId
                quiz.actionId = self.actionId
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }
        }else if assesmentQuiz.category?.caseInsensitiveCompare("material") == .orderedSame{
            let material = MaterialViewController()
            material.delegate = self
            material.topicId = self.topicId
            material.actionId = self.actionId
            material.index = self.indexPage
            material.quiz = assesmentQuiz
            material.modalPresentationStyle = .fullScreen
            
            self.embed(material, inParent: self, inView: self.embedView)
        }
    }
}
