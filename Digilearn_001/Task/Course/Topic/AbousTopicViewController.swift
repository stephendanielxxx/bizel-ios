//
//  AbousTopicViewController.swift
//  Digilearn_001
//
//  Created by Teke on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class AbousTopicViewController: UIViewController {

    var topicDesc = ""
    
    @IBOutlet weak var aboutText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutText.attributedText = topicDesc.aboutString
        // Do any additional setup after loading the view.
    }

}
