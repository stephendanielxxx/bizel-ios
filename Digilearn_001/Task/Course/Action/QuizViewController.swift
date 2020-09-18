//
//  QuizViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import Toast_Swift

class QuizViewController: BaseActionViewController {
    
    var delegate: QuizDelegate?
    var topicId = ""
    var actionId = ""
    var quiz: AssessmentQuizModel?
    var index: Int?
    var isCorrect = false
    
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizText: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonA: CustomChoiceCardView!
    @IBOutlet weak var lineA: UIView!
    @IBOutlet weak var buttonB: CustomChoiceCardView!
    @IBOutlet weak var lineB: UIView!
    @IBOutlet weak var buttonC: CustomChoiceCardView!
    @IBOutlet weak var lineC: UIView!
    @IBOutlet weak var buttonD: CustomChoiceCardView!
    @IBOutlet weak var lineD: UIView!
    @IBOutlet weak var optionA: UILabel!
    @IBOutlet weak var optionB: UILabel!
    @IBOutlet weak var optionC: UILabel!
    @IBOutlet weak var optionD: UILabel!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    // single, essay
    // read,watch, link, audio
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        quizImage.pin_updateWithProgress = true
        quizImage.contentMode = .scaleToFill
        quizImage.clipsToBounds = true
        
        quizImage.enableZoom()
        
        quizTitle.text = quiz?.title
        
        let content = replaceNickname(text: (quiz?.question)!)
        quizText.attributedText = content.htmlToAttributedString
        
        if quiz?.quizImage != nil && quiz?.quizImage?.caseInsensitiveCompare("none") != .orderedSame {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
            
            quizImage.pin_setImage(from: url)
        }else{
            quizImage.isHidden = true
            imageHeight.constant = 0
        }
        
        optionA.attributedText = quiz?.pil1!.htmlStringAnswerQuiz
        optionB.attributedText = quiz?.pil2!.htmlStringAnswerQuiz
        optionC.attributedText = quiz?.pil3!.htmlStringAnswerQuiz
        optionD.attributedText = quiz?.pil4!.htmlStringAnswerQuiz
        
        if index == 0 {
            prevButton.isHidden = true
        }else{
            prevButton.isHidden = false
        }
        
        buttonA.answer = quiz?.pil1
        buttonB.answer = quiz?.pil2
        buttonC.answer = quiz?.pil3
        buttonD.answer = quiz?.pil4
        
        buttonA.addTarget(self, action: #selector(QuizViewController.checkAnswerA(_:)), for: .touchUpInside)
        
        buttonB.addTarget(self, action: #selector(QuizViewController.checkAnswerB(_:)), for: .touchUpInside)
        
        buttonC.addTarget(self, action: #selector(QuizViewController.checkAnswerC(_:)), for: .touchUpInside)
        
        buttonD.addTarget(self, action: #selector(QuizViewController.checkAnswerD(_:)), for: .touchUpInside)
    }
    
    fileprivate func showCorrectToast() {
        var style = ToastStyle()
        style.backgroundColor = UIColor(named: "color_0CA422")!
        style.messageColor = UIColor.white
        ToastManager.shared.style = style
        
        self.view.makeToast("CORRECT. Great!")
    }
    
    fileprivate func showFalseToast() {
        var style = ToastStyle()
        style.backgroundColor = UIColor.red
        style.messageColor = UIColor.white
        ToastManager.shared.style = style
        
        self.view.makeToast("Incorrect Answer. Please try again!")
    }
    
    @objc func checkAnswerA(_ sender: CustomChoiceCardView?) {
        debugPrint(sender!.answer!)
        debugPrint(quiz!.answer!)
        lineA.backgroundColor = UIColor(named: "color_EFB8CB")
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast()
            isCorrect = true
        }else{
            showFalseToast()
        }
        
    }
    
    @objc func checkAnswerB(_ sender: CustomChoiceCardView?) {
        debugPrint(sender!.answer!)
        debugPrint(quiz!.answer!)
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor(named: "color_EFB8CB")
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast()
            isCorrect = true
        }else{
            showFalseToast()
        }
    }
    
    @objc func checkAnswerC(_ sender: CustomChoiceCardView?) {
        debugPrint(sender!.answer!)
        debugPrint(quiz!.answer!)
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor(named: "color_EFB8CB")
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast()
            isCorrect = true
        }else{
            showFalseToast()
        }
    }
    
    @objc func checkAnswerD(_ sender: CustomChoiceCardView?) {
        debugPrint(sender!.answer!)
        debugPrint(quiz!.answer!)
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor(named: "color_EFB8CB")
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast()
            isCorrect = true
        }else{
            showFalseToast()
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if isCorrect {
            delegate?.nextAction(index: index!)
        }else{
            showFalseToast()
        }
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
}

protocol QuizDelegate {
    func nextAction(index: Int)
    func prevAction(index: Int)
}
