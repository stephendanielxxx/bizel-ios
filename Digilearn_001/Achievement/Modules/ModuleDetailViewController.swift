//
//  ModuleDetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ModuleDetailViewController: UIViewController {
    @IBOutlet weak var titleModule: UILabel!
    @IBOutlet weak var institutModule: UILabel!
    @IBOutlet weak var imageModul: UIImageView!
    @IBOutlet weak var topicsButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    
    
    var course_id = ""
    var module_id = ""
    var module_image = ""
    var module_download = ""
    var module_name = ""
    var institute_name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleModule.text = self.module_name
        institutModule.text = self.institute_name
        imageModul.pin_updateWithProgress = true
        imageModul.contentMode = .scaleToFill
        imageModul.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/course/image/\(module_image)")
        imageModul.pin_setImage(from: url)
        
        
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

}
