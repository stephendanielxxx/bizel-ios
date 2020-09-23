//
//  ActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 16/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class ActionViewController: UIViewController {
    
    var isLibrary = false
    var moduleTitle = ""
    var courseId = ""
    var moduleId = ""
    var topicId = ""
    var actionId = ""
    var nextTopicId = ""
    var nextModuleName = ""
    let URL = "\(DigilearnParams.ApiUrl)/quiz/get_quiz_course"
    var assesmentModel: AssesmentModel!
    var indexPage = 0
    var totalPage = 0
    
    var actionViewDelegate: ActionViewDelegate!
    
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
                            
                            self.totalPage = self.assesmentModel.assessmentQuiz?.count as! Int
                            
                            self.openAction(index: self.indexPage)
                            
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

extension ActionViewController: QuizDelegate, ModuleFinishDelegate{
    
    fileprivate func openAction(index: Int) {
        let assesmentQuiz = self.assesmentModel.assessmentQuiz![indexPage]
        
        if assesmentQuiz.category?.caseInsensitiveCompare("quiz") == .orderedSame {
            if assesmentQuiz.quizType?.caseInsensitiveCompare("single") == .orderedSame {
                let quiz = QuizViewController()
                quiz.delegate = self
                quiz.courseId = self.courseId
                quiz.moduleId = self.moduleId
                quiz.topicId = assesmentQuiz.topicID!
                quiz.actionId = assesmentQuiz.actionID!
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }else if assesmentQuiz.quizType?.caseInsensitiveCompare("essay") == .orderedSame {
                let quiz = QuizEssayViewController()
                quiz.delegate = self
                quiz.courseId = self.courseId
                quiz.moduleId = self.moduleId
                quiz.topicId = assesmentQuiz.topicID!
                quiz.actionId = assesmentQuiz.actionID!
                quiz.index = self.indexPage
                quiz.quiz = assesmentQuiz
                quiz.modalPresentationStyle = .fullScreen
                
                self.embed(quiz, inParent: self, inView: self.embedView)
            }
        }else if assesmentQuiz.category?.caseInsensitiveCompare("material") == .orderedSame{
            if assesmentQuiz.materialType?.caseInsensitiveCompare("Read") == .orderedSame{
                let material = MaterialViewController()
                material.delegate = self
                material.courseId = self.courseId
                material.moduleId = self.moduleId
                material.topicId = assesmentQuiz.topicID!
                material.actionId = assesmentQuiz.actionID!
                material.index = self.indexPage
                material.quiz = assesmentQuiz
                material.modalPresentationStyle = .fullScreen
                
                self.embed(material, inParent: self, inView: self.embedView)
            }else if assesmentQuiz.materialType?.caseInsensitiveCompare("Watch Link") == .orderedSame{
                let material = MaterialLinkViewController()
                material.delegate = self
                material.courseId = self.courseId
                material.moduleId = self.moduleId
                material.topicId = assesmentQuiz.topicID!
                material.actionId = assesmentQuiz.actionID!
                material.index = self.indexPage
                material.quiz = assesmentQuiz
                material.modalPresentationStyle = .fullScreen
                
                self.embed(material, inParent: self, inView: self.embedView)
            }else if assesmentQuiz.materialType?.caseInsensitiveCompare("Watch") == .orderedSame{
                let material = MaterialVideoViewController()
                material.delegate = self
                material.courseId = self.courseId
                material.moduleId = self.moduleId
                material.topicId = assesmentQuiz.topicID!
                material.actionId = assesmentQuiz.actionID!
                material.index = self.indexPage
                material.quiz = assesmentQuiz
                material.modalPresentationStyle = .fullScreen
                
                self.embed(material, inParent: self, inView: self.embedView)
            }
            
        }
    }
    
    func nextAction(index: Int) {
        self.indexPage = index + 1
        
        if indexPage == totalPage {
            if nextTopicId.caseInsensitiveCompare("buntu") == .orderedSame{
                let moduleFinish = ModuleFinishViewController()
                moduleFinish.moduleFinishDelegate = self
                moduleFinish.currentModule = moduleTitle
                moduleFinish.nextModule = nextModuleName
                moduleFinish.modalPresentationStyle = .fullScreen
                
                self.present(moduleFinish, animated: true, completion: nil)
                
            }else{
                self.dismiss(animated: true, completion: nil)
            }
        }else{
            openAction(index: self.indexPage)
            
        }
    }
    
    func prevAction(index: Int) {
        self.indexPage = index - 1
        
        openAction(index: self.indexPage)
    }
    
    func onBackToModule() {
        self.actionViewDelegate.onModuleFinish()
    }
    
}

protocol ActionViewDelegate {
    func onModuleFinish()
}
