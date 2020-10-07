//
//  MyGroupViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//
import UIKit
import Alamofire
import Reqres
import PINRemoteImage


class MyGroupViewController: UIViewController {
    @IBOutlet weak var groupView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    var groupModel: GroupModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView.delegate = self
        groupView.dataSource = self
        let nib = UINib(nibName: "MyGrouppTableViewCell", bundle: nil)
        groupView.register(nib, forCellReuseIdentifier: "GroupIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/user/auth/get_all_group"
        let parameters: [String:Any] = [
            "user_id": "\(user_id)"
        ]
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.groupModel = try decoder.decode(GroupModel.self, from:data)
                            
                            if self.groupModel.listGroup.count > 0 {
                                self.emptyView.isHidden = true
                                self.groupView.isHidden = false
                            }else{
                                self.emptyView.isHidden = false
                                self.groupView.isHidden = true
                            }
                            
                            self.groupView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                            self.emptyView.isHidden = true
                            self.groupView.isHidden = false
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
extension MyGroupViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupModel?.listGroup.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupView.dequeueReusableCell(withIdentifier: "GroupIdentifier") as! MyGroupTableViewCell
        let group: ListGroup = (groupModel?.listGroup[indexPath.row])!
        cell.titleLabel.text = group.groupName
        cell.imageGroup.pin_updateWithProgress = true
       // cell.imageGroup.layer.cornerRadius = 1
        cell.imageGroup.contentMode = .scaleToFill
        cell.imageGroup.clipsToBounds = true
        
       
        if(group.groupImage != nil) {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/group/profile/\(group.groupImage!)")
            cell.imageGroup.pin_setImage(from: url)
        }else{
            cell.imageGroup.image = UIImage(named: "ic_default_group")
        }
        cell.groupDetail.tag = indexPath.row
        cell.groupDetail.addTarget(self,action: #selector(MyGroupViewController.openDetail(_:)),for: .touchUpInside)
                return cell
    }
    @objc func openDetail(_ sender: UIButton?) {
        let groupDetail = MyGroupDetailViewController()
        groupDetail.modalPresentationStyle = .fullScreen
        let listgroup: ListGroup = groupModel.listGroup[sender!.tag]
        groupDetail.titlegroup = listgroup.groupName
        groupDetail.image = listgroup.groupImage ?? ""
        groupDetail.titlegroupisi = listgroup.groupAbout
        groupDetail.groupid = listgroup.groupID 
        self.present(groupDetail, animated: true, completion: nil)
        
    }
    

}


