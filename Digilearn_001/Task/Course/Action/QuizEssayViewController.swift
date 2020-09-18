//
//  QuizEssayViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import Alamofire

class QuizEssayViewController: BaseActionViewController, ActionDelegate {
    var delegate: QuizDelegate?
    
    var quiz: AssessmentQuizModel?
    var index: Int?
    
    var essayModel: EssayModel!
    
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizText: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var undoButton: UIButton!
    @IBOutlet weak var redoButton: UIButton!
    let URL = "\(DigilearnParams.ApiUrl)/score/get_essayById"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionDelegate = self
        
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        quizImage.pin_updateWithProgress = true
        quizImage.contentMode = .scaleToFill
        quizImage.clipsToBounds = true
        
        quizTitle.text = quiz?.title
        
        let content = replaceNickname(text: (quiz?.question)!)
        quizText.attributedText = content.htmlToAttributedString
        
        if quiz?.quizImage != nil{
            
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
            
            quizImage.pin_setImage(from: url)
        }
        
        if index == 0 {
            prevButton.isHidden = true
        }else{
            prevButton.isHidden = false
        }
        scrollView.bounces = (scrollView.contentOffset.y > 100);
        updateUndoButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAnswer()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if answerField.text!.isEmpty {
            showFalseToast(message: "Please input your answer")
        }else{
            submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: answerField.text ?? "")
            delegate?.nextAction(index: index!)
        }
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
    
    func loadAnswer(){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let parameters: [String:Any] = [
            "user_id": "\(user_id)",
            "course_id": "\(self.courseId)",
            "module_id": "\(self.moduleId)",
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
                            self.essayModel = try decoder.decode(EssayModel.self, from:data)
                            if self.essayModel.responseStatus {
                                self.answerField.attributedText = self.essayModel.responseData.htmlToAttributedString
                                self.undoButton.isHidden = true
                                self.redoButton.isHidden = true
                            }
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
    
    @IBAction func undoAction(_ sender: UIButton) {
        answerField.undoManager?.undo()
        updateUndoButtons()
    }
    
    @IBAction func redoAction(_ sender: UIButton) {
        answerField.undoManager?.redo()
        updateUndoButtons()
    }

    func updateUndoButtons() {
//        undoButton.isEnabled = answerField.undoManager?.canUndo ?? false
//        redoButton.isEnabled = answerField.undoManager?.canRedo ?? false
    }
    
    func onSubmitProgress(message: String) {
        
    }
}

extension QuizEssayViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUndoButtons()
    }
}
