//
//  QuizEssayViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class QuizEssayViewController: UIViewController {
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
    @IBOutlet weak var answerField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        quizImage.pin_updateWithProgress = true
        quizImage.contentMode = .scaleToFill
        quizImage.clipsToBounds = true
        
        quizTitle.text = quiz?.title
        
        quizText.attributedText = quiz?.question?.htmlToAttributedString
        
        if quiz?.quizImage != nil{
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(quiz!.quizImage!)")!
            
            quizImage.pin_setImage(from: url)
        }
        
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
