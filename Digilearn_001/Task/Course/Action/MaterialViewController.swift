//
//  MaterialViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class MaterialViewController: BaseActionViewController {
    
    var delegate: QuizDelegate?
    var topicId = ""
    var actionId = ""
    var quiz: AssessmentQuizModel?
    var index: Int?
    
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var materialTitle: UILabel!
    @IBOutlet weak var materialImage: UIImageView!
    @IBOutlet weak var materialContent: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    // single, essay
    // read,watch, link, audio
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.cornerRadius = 15
        prevButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        materialImage.pin_updateWithProgress = true
        materialImage.contentMode = .scaleToFill
        materialImage.clipsToBounds = true
        
        materialTitle.text = quiz?.title
        
        let content = replaceNickname(text: (quiz?.content)!)
        materialContent.attributedText = content.htmlToAttributedString
        
        if quiz?.contentImage != nil && quiz?.contentImage?.caseInsensitiveCompare("none") != .orderedSame{
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/material/image/\(quiz!.contentImage!)")!
            
            materialImage.pin_setImage(from: url)
            
        }else{
            materialImage.isHidden = true
            imageHeight.constant = 0
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
