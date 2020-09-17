//
//  QuizViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class QuizViewController: BaseActionViewController {
    
    var delegate: QuizDelegate?
    var topicId = ""
    var actionId = ""
    var quiz: AssessmentQuizModel?
    var index: Int?
    
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizText: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var buttonA: MDCCard!
    @IBOutlet weak var lineA: UIView!
    @IBOutlet weak var buttonB: MDCCard!
    @IBOutlet weak var lineB: UIView!
    @IBOutlet weak var buttonC: MDCCard!
    @IBOutlet weak var lineC: UIView!
    @IBOutlet weak var buttonD: MDCCard!
    @IBOutlet weak var lineD: UIView!
    @IBOutlet weak var optionA: UILabel!
    @IBOutlet weak var optionB: UILabel!
    @IBOutlet weak var optionC: UILabel!
    @IBOutlet weak var optionD: UILabel!
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
        
        if quiz?.quizImage != nil{
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
            
            quizImage.pin_setImage(from: url)
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
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        delegate?.nextAction(index: index!)
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
}

protocol QuizDelegate {
    func nextAction(index: Int)
    func prevAction(index: Int)
}
