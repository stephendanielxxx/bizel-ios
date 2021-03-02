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

class QuizViewController: BaseActionViewController, ActionDelegate {
    
    var delegate: QuizDelegate?
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
    @IBOutlet weak var optionA: UITextView!
    @IBOutlet weak var optionB: UITextView!
    @IBOutlet weak var optionC: UITextView!
    
    @IBOutlet weak var optionD: UITextView!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var downloadButton: UIButton!
    // single, essay
    // read,watch, link, audio
    override func viewDidLoad() {
        super.viewDidLoad()
        actionDelegate = self
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        quizImage.pin_updateWithProgress = true
        quizImage.contentMode = .scaleToFill
        quizImage.clipsToBounds = true
        
        quizImage.enableZoom()
        
        quizTitle.text = quiz?.title
        
        let content = replaceNickname(text: (quiz?.question)!)
        quizText.attributedText = content.activityString
        
        if quiz?.quizImage != nil && quiz?.quizImage?.caseInsensitiveCompare("none") != .orderedSame {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
            let imageSize: CGSize? = sizeOfImageAt(url: url)
            let ratio = imageSize!.width/imageSize!.height
            let frameHeight = quizImage.frame.width/ratio
            //materialImage.frame.size.height = frameHeight
            imageHeight.constant = frameHeight
                        debugPrint(imageSize?.width)
                        debugPrint(imageSize?.height)
                        debugPrint(frameHeight)
            
                        debugPrint(quizImage.frame.width)
                        debugPrint(imageHeight)

            quizImage.pin_setImage(from: url)
        }else{
            quizImage.isHidden = true
            imageHeight.constant = 0
            downloadButton.isHidden = true
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

        let tap = QuizAnswerTapGesture(target: self, action: #selector(checkAnswerA(_:)))
        tap.answer = quiz?.pil1
        buttonA.addGestureRecognizer(tap)
        
        let tapB = QuizAnswerTapGesture(target: self, action: #selector(checkAnswerB(_:)))
        tapB.answer = quiz?.pil2
        buttonB.addGestureRecognizer(tapB)
        
        let tapC = QuizAnswerTapGesture(target: self, action: #selector(checkAnswerC(_:)))
        tapC.answer = quiz?.pil3
        buttonC.addGestureRecognizer(tapC)
        
        let tapD = QuizAnswerTapGesture(target: self, action: #selector(checkAnswerD(_:)))
        tapD.answer = quiz?.pil4
        buttonD.addGestureRecognizer(tapD)
        
        
        scrollview.bounces = (scrollview.contentOffset.y > 100);
    }
    
    @objc func checkAnswerA(_ sender: QuizAnswerTapGesture?) {
        lineA.backgroundColor = UIColor(named: "color_EFB8CB")
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast(message: "CORRECT. Great!")
            isCorrect = true
        }else{
            isCorrect = false
            showFalseToast(message: "Incorrect Answer. Please try again!")
        }
        
    }
    
    @objc func checkAnswerB(_ sender: QuizAnswerTapGesture?) {
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor(named: "color_EFB8CB")
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast(message: "CORRECT. Great!")
            isCorrect = true
        }else{
            isCorrect = false
            showFalseToast(message: "Incorrect Answer. Please try again!")
        }
    }
    
    @objc func checkAnswerC(_ sender: QuizAnswerTapGesture?) {
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor(named: "color_EFB8CB")
        lineD.backgroundColor = UIColor.darkGray
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast(message: "CORRECT. Great!")
            isCorrect = true
        }else{
            isCorrect = false
            showFalseToast(message: "Incorrect Answer. Please try again!")
        }
    }
    
    @objc func checkAnswerD(_ sender: QuizAnswerTapGesture?) {
        lineA.backgroundColor = UIColor.darkGray
        lineB.backgroundColor = UIColor.darkGray
        lineC.backgroundColor = UIColor.darkGray
        lineD.backgroundColor = UIColor(named: "color_EFB8CB")
        
        if sender!.answer!.caseInsensitiveCompare(String(describing: quiz!.answer!)) == .orderedSame {
            showCorrectToast(message: "CORRECT. Great!")
            isCorrect = true
        }else{
            isCorrect = false
            showFalseToast(message: "Incorrect Answer. Please try again!")
        }
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        if isCorrect {
            submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: (quiz?.answer)!, assign_id: assign_id)
            delegate?.nextAction(index: index!)
        }else{
            showFalseToast(message: "Please select the answer!")
        }
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
    
    @IBAction func downloadAction(_ sender: UIButton) {
        downloadImage(filename: quiz!.quizImage!)
    }
    
    func onSubmitProgress(message: String) {
      
    }
}

protocol QuizDelegate {
    func nextAction(index: Int)
    func prevAction(index: Int)
}

