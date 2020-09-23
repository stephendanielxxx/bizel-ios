//
//  MaterialVideoViewController.swift
//  Digilearn_001
//
//  Created by Teke on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards
import ASPVideoPlayer
import AVFoundation

class MaterialVideoViewController: BaseActionViewController, ActionDelegate {

    var delegate: QuizDelegate!
    var quiz: AssessmentQuizModel?
    var index: Int?
    @IBOutlet weak var cardView: MDCCard!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var materialTitle: UILabel!
    
    @IBOutlet weak var videoPlayer: ASPVideoPlayer!
    
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
        
        var videoUrl = "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/material/video/\(quiz!.file!)"
        let secondNetworkURL = URL(string: videoUrl)
        let secondAsset = AVURLAsset(url: secondNetworkURL!)
        videoPlayer.backgroundColor = UIColor.white
        
        videoPlayer.videoAssets = [secondAsset]
        videoPlayer.videoPlayerControls.tintColor = UIColor(named: "red_1")
    
    }
    
    @IBAction func prevAction(_ sender: UIButton) {
         delegate?.prevAction(index: index!)
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        submitProgress(courseId: courseId, moduleId: moduleId, topicId: (quiz?.topicID)!, actionId: (quiz?.actionID)!, answer: "")
               delegate?.nextAction(index: index!)
    }
    
    func onSubmitProgress(message: String) {
        
    }
}
