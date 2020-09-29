//
//  AchievementDetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//


import UIKit

class AchievementDetailViewController: UIViewController {
    @IBOutlet weak var titleAchieve: UILabel!
    @IBOutlet weak var institutName: UILabel!
    @IBOutlet weak var imageAchieve: UIImageView!
    @IBOutlet weak var topicsButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var image = ""
    var titleachieve = ""
    var institutname = ""
    var courseid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

            titleAchieve.text = self.titleachieve
            institutName.text = self.institutname
            imageAchieve.pin_updateWithProgress = true
            imageAchieve.contentMode = .scaleToFill
            imageAchieve.clipsToBounds = true
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/course/image/\(image)")
            imageAchieve.pin_setImage(from: url)
        }
        
    @IBAction func backButton(_ sender: Any) { self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func detailButton(_ sender: UIButton) {
        debugPrint(courseid)
            let detail = DetailViewController()
                 detail.course_id = courseid
                 embed(detail,inParent: self,inView: contentView)
        
    }
    
    
}

