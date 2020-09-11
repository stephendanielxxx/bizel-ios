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
    var groupModel: GroupModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupView.delegate = self
        groupView.dataSource = self
        let nib = UINib(nibName: "MyGroupTableViewCell", bundle: nil)
        groupView.register(nib, forCellReuseIdentifier: "MyGroupIdentifier")
        
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
                            self.groupView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
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
        let cell = groupView.dequeueReusableCell(withIdentifier: "MyGroupIdentifier") as! MyGroupTableViewCell
        let group: ListGroup = (groupModel?.listGroup[indexPath.row])!
        cell.titleGroup.text = group.groupName
        cell.imageGroup.pin_updateWithProgress = true
       // cell.imageGroup.layer.cornerRadius = 1
        cell.imageGroup.contentMode = .scaleToFill
        cell.imageGroup.clipsToBounds = true
        
       
        if(group.groupImage != nil) {
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/group/profile/\(group.groupImage)")
             debugPrint("https://digicourse.id/digilearn/admin-master/assets.admin_master/group/profile/\(group.groupImage)")
            cell.imageGroup.pin_setImage(from: url)
        }
                return cell
    }
}


