//
//  GroupChatViewController.swift
//  Digilearn_001
//
//  Created by Teke on 28/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class GroupChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var groupModel: GroupModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "img_bg_chat"))
        
        let nib = UINib(nibName: "GroupChatTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "groupChatIdentifier")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadGroup()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadGroup(){
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
                            self.tableView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
}

extension GroupChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupModel?.listGroup.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupChatIdentifier") as! GroupChatTableViewCell
        
        let group: ListGroup = groupModel.listGroup[indexPath.row]
        
        cell.groupNameLabel.text = group.groupName
        cell.lastChatLabel.text = "Ini Chat"
        
        return cell
    }
}
