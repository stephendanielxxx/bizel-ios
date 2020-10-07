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
    @IBOutlet weak var isiActive: UIButton!
    @IBOutlet weak var isiExpired: UIButton!
    @IBOutlet weak var isiMember: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var image = ""
    var titlegroupp = ""
    var titlegroupisi = ""
    var groupid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.title = self.titlegroupp
        detailTitleIsi.text = self.titlegroupisi
        detailImageGroup.pin_updateWithProgress = true
        // cell.imageGroup.layer.cornerRadius = 1
        detailImageGroup.contentMode = .scaleToFill
        detailImageGroup.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/group/profile/\(image)")
        detailImageGroup.pin_setImage(from: url)
        
        setActiveView()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setMemberView() {
        isiMember.backgroundColor = UIColor(named: "red_1")
        isiActive.backgroundColor = UIColor.lightGray
        isiExpired.backgroundColor = UIColor.lightGray
        
        let member = MemberGroupViewController()
        member.group_id = groupid
        embed(member,inParent: self,inView: contentView)
    }
    
    fileprivate func setActiveView() {
        isiActive.backgroundColor = UIColor(named: "red_1")
        isiMember.backgroundColor = UIColor.lightGray
        isiExpired.backgroundColor = UIColor.lightGray
        
        let active = ActiveTaskViewController()
        active.group_id = groupid
        embed(active,inParent: self,inView: contentView)
    }
    
    fileprivate func setExpiredView() {
           isiExpired.backgroundColor = UIColor(named: "red_1")
           isiActive.backgroundColor = UIColor.lightGray
           isiMember.backgroundColor = UIColor.lightGray
           
           let expired = ExpiredTaskViewController()
           expired.group_id = groupid
           embed(expired,inParent: self,inView: contentView)
       }
    
    @IBAction func memberButton(_ sender: UIButton) {
        setMemberView()
    }
    
    @IBAction func activeButton(_ sender: Any) {
        setActiveView()
    }
    
    @IBAction func expiredButton(_ sender: Any) {
        setExpiredView()
    }
    
}
