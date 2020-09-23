//
//  MyGroupDetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit


class MyGroupDetailViewController: UIViewController {
    
    @IBOutlet weak var detailImageGroup: UIImageView!
    @IBOutlet weak var detailTitle: UINavigationItem!
    @IBOutlet weak var detailTitleIsi: UILabel!
    @IBOutlet weak var isiMember: UIView!
    @IBOutlet weak var isiActive: UIButton!
    @IBOutlet weak var isiExpired: UIButton!
    @IBOutlet weak var isiActiveTask: UIView!
    @IBOutlet weak var isiExpiredTask: UIView!
    
    var image = ""
    var titlegroup = ""
    var titlegroupisi = ""
    var groupid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.title = self.titlegroup
        detailTitleIsi.text = self.titlegroupisi
        detailImageGroup.pin_updateWithProgress = true
        // cell.imageGroup.layer.cornerRadius = 1
        detailImageGroup.contentMode = .scaleToFill
        detailImageGroup.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/group/profile/\(image)")
        detailImageGroup.pin_setImage(from: url)
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func memberButton(_ sender: UIButton) {
        
        let member = MemberGroupViewController()
        member.group_id = groupid
        embed(member,inParent: self,inView: isiMember)
        
        
    }
    @IBAction func activeButton(_ sender: Any) {
    }
    
    @IBAction func expiredButton(_ sender: Any) {
    }
    
}
