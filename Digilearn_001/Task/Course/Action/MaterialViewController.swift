//
//  MaterialViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import Alamofire

class MaterialViewController: BaseActionViewController, ActionDelegate {
    
    var delegate: QuizDelegate?
    var quiz: AssessmentQuizModel?
    var index: Int?
    
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var materialTitle: UILabel!
    @IBOutlet weak var materialImage: UIImageView!
    @IBOutlet weak var materialContent: UITextView!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
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
        materialImage.pin_updateWithProgress = true
        materialImage.contentMode = .scaleToFill
        materialImage.clipsToBounds = true
        
        materialTitle.text = quiz?.title
        
        let content = replaceNickname(text: (quiz?.content)!)
        materialContent.attributedText = content.activityString
        
        if quiz?.contentImage != nil && quiz?.contentImage?.caseInsensitiveCompare("none") != .orderedSame{
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/material/image/\(quiz!.contentImage!)")!
        
//            materialImage.pin_setImage(from: url)
            materialImage.pin_setImage(from: url, placeholderImage: UIImage(named: "ic_logo_bizel_white"), completion: { (result) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    
                    let imageSize: CGSize? = self.sizeOfImageAt(url: url)
                    let ratio = imageSize!.width/imageSize!.height
                                        
                    let frameHeight = self.materialImage.frame.size.width/ratio
                    self.materialImage.frame.size.height = frameHeight
                    self.imageHeight.constant = frameHeight
                    
                }
            })
        
        }else{
            materialImage.isHidden = true
            imageHeight.constant = 0
            downloadButton.isHidden = true
        }
        
        if index == 0 {
            prevButton.isHidden = true
        }else{
            prevButton.isHidden = false
        }
        
        scrollview.bounces = (scrollview.contentOffset.y > 100);
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: "", assign_id: assign_id)
        delegate?.nextAction(index: index!)
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
        delegate?.prevAction(index: index!)
    }
    
    func onSubmitProgress(message: String) {
        
    }
    
    @IBAction func downloadAction(_ sender: UIButton) {
        downloadImage(filename: quiz!.quizImage!)
        
    }
}
