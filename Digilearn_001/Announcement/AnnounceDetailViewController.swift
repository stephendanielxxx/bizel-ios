//
//  AnnounceDetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class AnnounceDetailViewController: UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var titleDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    
    @IBOutlet weak var newsDetail: UITextView!
    var image = ""
    var newstitle = ""
    var date = ""
    var news = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint(image)
        titleDetail.text = self.newstitle
        dateDetail.text = self.date
        newsDetail.attributedText = self.news.htmlToAttributedString
        imageDetail.pin_updateWithProgress = true
        // cell.imageGroup.layer.cornerRadius = 1
       imageDetail.contentMode = .scaleToFill
        imageDetail.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/announcement/image/\(image)")
        imageDetail.pin_setImage(from: url)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
