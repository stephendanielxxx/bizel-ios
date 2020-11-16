//
//  MaterialLinkViewController.swift
//  Digilearn_001
//
//  Created by Teke on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class MaterialLinkViewController: BaseActionViewController, ActionDelegate {
    var delegate: QuizDelegate!
    var quiz: AssessmentQuizModel?
    var index: Int?
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var materialTitle: UILabel!
    @IBOutlet weak var materialLink: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionDelegate = self
        
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        
        materialTitle.text = quiz?.title
        
        if index == 0 {
            prevButton.isHidden = true
        }else{
            prevButton.isHidden = false
        }
        
        scrollView.bounces = (scrollView.contentOffset.y > 100);
        
        materialLink.text = quiz?.contentVideoLink
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: "", assign_id: assign_id)
        delegate?.nextAction(index: index!)
    }
    
    func onSubmitProgress(message: String) {
        
    }
    
}
