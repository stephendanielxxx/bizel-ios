//
//  AnnounViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Reqres
import PINRemoteImage


class AnnounceViewController: UIViewController {
    
    @IBOutlet weak var announcementView: UITableView!
    var announcementModel : AnnouncementModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        announcementView.delegate = self
        announcementView.dataSource = self
        let nib = UINib(nibName: "AnnounceTableViewCell", bundle: nil)
        announcementView.register(nib, forCellReuseIdentifier: "AnnounceIdentifier")
        
        let URL = "\(DigilearnParams.ApiUrl)/home/get_news"
        
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.announcementModel = try decoder.decode(AnnouncementModel.self, from:data)
                            self.announcementView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
        
    }
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AnnounceViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcementModel?.news.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = announcementView.dequeueReusableCell(withIdentifier: "AnnounceIdentifier") as! AnnounceTableViewCell
        let announcement: News = (announcementModel?.news[indexPath.row])!
        cell.titleAnnounce.text = announcement.title
        cell.dateAnnounce.text = announcement.timePosted
        cell.imageAnnounce.pin_updateWithProgress = true
        // cell.imageGroup.layer.cornerRadius = 1
        cell.imageAnnounce.contentMode = .scaleToFill
        cell.imageAnnounce.clipsToBounds = true
        
        
        if announcement.announcementImage != nil {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/announcement/image/\(announcement.announcementImage)")
            cell.imageAnnounce.pin_setImage(from: url)
            
            if(indexPath.row == 0){
                cell.newLabel.isHidden = false
            }else{
                cell.newLabel.isHidden = true
            }
        }
        
        cell.detailAnnounce.tag = indexPath.row
        cell.detailAnnounce.addTarget(self, action: #selector(AnnounceViewController.openDetail(_:)), for: .touchUpInside)
        return cell
    }
    @objc func openDetail(_ sender: UIButton?) {
        let announceDetail = AnnounceDetailViewController()

        announceDetail.modalPresentationStyle = .fullScreen
        let news: News = announcementModel.news[sender!.tag]
        announceDetail.date = news.timePosted
        announceDetail.image = news.announcementImage
        announceDetail.news = news.isi
        announceDetail.newstitle = news.title
        
        self.present(announceDetail, animated: true, completion: nil)
    }

    
}


