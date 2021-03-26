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
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
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
        quizText.attributedText = content.activityString
        
        if quiz?.quizImage != nil && quiz?.quizImage?.caseInsensitiveCompare("none") != .orderedSame {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
          //  let imageSize: CGSize? = sizeOfImageAt(url: url)
            quizImage.pin_setImage(from: url, placeholderImage: UIImage(named: "ic_logo_bizel_white"), completion: { (result) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    
                    let imageSize: CGSize? = self.sizeOfImageAt(url: url)
                    let ratio = imageSize!.width/imageSize!.height
                                        
                    let frameHeight = self.quizImage.frame.size.width/ratio
                    self.quizImage.frame.size.height = frameHeight
                    self.imageHeight.constant = frameHeight
                }
            })
        }else{
            quizImage.isHidden = true
            imageHeight.constant = 0
            downloadButton.isHidden = true
        }
       
        if index == 0 {
            prevButton.isHidden = true
        }else{
            prevButton.isHidden = false
        }
        scrollView.bounces = (scrollView.contentOffset.y > 100);
        updateUndoButtons()
        
        if isLibrary {
            answerField.isHidden = true
            undoButton.isHidden = true
            redoButton.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadAnswer()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if !isLibrary {
            if answerField.text!.isEmpty {
                showFalseToast(message: "Please input your answer")
            }else{
                submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: answerField.text ?? "", assign_id: assign_id)
                delegate?.nextAction(index: index!)
            }
        }else{
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
                    case .failure(_):
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
    
    @IBAction func downloadAction(_ sender: UIButton) {
        downloadImage(filename: quiz!.quizImage!)
    }
}

extension QuizEssayViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUndoButtons()
    }
}
