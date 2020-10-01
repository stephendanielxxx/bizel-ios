//
//  ModuleDetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ModuleDetailViewController: UIViewController {
    @IBOutlet weak var titleModule: UILabel!
    @IBOutlet weak var institutModule: UILabel!
    @IBOutlet weak var imageModul: UIImageView!
    @IBOutlet weak var topicsButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var course_id = ""
    var module_id = ""
    var image = ""
    var download = ""
    var modulename = ""
    var institut = ""
    
    var modulesModel: ModulesModel!
    var achieveModel: AchieveModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(institut)
        
        titleModule.text = self.modulename
        institutModule.text = self.institut
        imageModul.pin_updateWithProgress = true
        imageModul.contentMode = .scaleToFill
        imageModul.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/module/image/\(image)")
        imageModul.pin_setImage(from: url)
   
        
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func topicsButton(_ sender: UIButton) {
    }
    
    @IBAction func detailsButton(_ sender: UIButton) {
        debugPrint("test")
        let detail = DetailtopicViewController()
               detail.module_id = module_id
               embed(detail,inParent: self,inView: contentView)
               
    }
    

}
