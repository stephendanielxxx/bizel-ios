//
//  AboutCourseViewController.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class AboutCourseViewController: UIViewController {

    var course_about = ""
    
    @IBOutlet weak var courseDetail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let font = UIFont.systemFont(ofSize: 72)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedQuote = NSAttributedString(string: course_about, attributes: attributes)
        courseDetail.attributedText = course_about.htmlToAttributedString
        // Do any additional setup after loading the view.
    }
}
