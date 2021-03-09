//
//  TopicViewController.swift
//  Digilearn_001
//
//  Created by Teke on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import PINRemoteImage

class TopicViewController: UIViewController, TopicActionDelegate {
    
    @IBOutlet weak var imageModule: UIImageView!
    @IBOutlet weak var titleModule: UILabel!
    @IBOutlet weak var createdModule: UILabel!
    @IBOutlet weak var topicBUtton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var topicLine: UIView!
    @IBOutlet weak var aboutLine: UIView!
    @IBOutlet weak var tabContent: UIView!
    
    var moduleImage = ""
    var moduleTitle = ""
    var moduleAuthor = ""
    var moduleDesc = ""
    var courseId = ""
    var moduleId = ""
    var assign_id = ""
    var nextModuleName = ""
    var isLibrary = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleModule.text = self.moduleTitle
        createdModule.text = "Created By \(self.moduleAuthor)"
        
        self.imageModule.pin_updateWithProgress = true
        self.imageModule.contentMode = .scaleToFill
        self.imageModule.clipsToBounds = true
       
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/module/image/\(self.moduleImage)")!

        self.imageModule.pin_setImage(from: url)
        
        setInitial()
    }
    
    func setInitial(){
       showTopicAction()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func showTopicAction() {
        let topics = TopicActionViewController()
        topics.topicActionDelegate = self
        topics.courseId = courseId
        topics.moduleId = moduleId
        topics.assign_id = assign_id
        topics.nextModuleName = nextModuleName
        topics.isLibrary = self.isLibrary
        embed(topics, inParent: self, inView: tabContent)
    }
    
    @IBAction func topicAction(_ sender: UIButton) {
        topicBUtton.setTitleColor(UIColor(named: "red_1"), for: .normal)
        aboutButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        topicLine.backgroundColor = UIColor(named: "red_1")
        aboutLine.backgroundColor = UIColor.white
        
        showTopicAction()
    }
    
    @IBAction func aboutAction(_ sender: UIButton) {
        aboutButton.setTitleColor(UIColor(named: "red_1"), for: .normal)
        topicBUtton.setTitleColor(UIColor.lightGray, for: .normal)
        
        aboutLine.backgroundColor = UIColor(named: "red_1")
        topicLine.backgroundColor = UIColor.white
        
        let about = AbousTopicViewController()
        about.topicDesc = moduleDesc
        
        embed(about, inParent: self, inView: tabContent)
    }
    
    func onDismissScreen() {
       
        self.dismiss(animated: true, completion: nil)
    }
}
