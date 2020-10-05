//
//  GroupChatViewController.swift
//  Digilearn_001
//
//  Created by Teke on 28/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import FirebaseDatabase
import CodableFirebase

class GroupChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var groupModel: GroupModel!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "GroupChatTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "groupChatIdentifier")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadGroup()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                            
                            if self.groupModel.listGroup.count > 0 {
                                debugPrint("1")
                                self.emptyView.isHidden = true
                                self.tableView.isHidden = false
                                
                                self.tableView.backgroundView = UIImageView(image: UIImage(named: "img_bg_chat"))
                            }else{
                                debugPrint("2")
                                self.emptyView.isHidden = false
                                self.tableView.isHidden = true
                            }
                            
                            self.tableView.reloadData()
                        }catch{
                            debugPrint("3")
                            print(error.localizedDescription)
                            self.emptyView.isHidden = false
                            self.tableView.isHidden = true
                        }
                    case .failure(_):
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
        
        var model: LastChatModel?
        ref = Database.database().reference().child(group.groupID)
        
        self.ref.queryLimited(toLast: 1).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                model = try FirebaseDecoder().decode(LastChatModel.self, from: value)
                cell.lastChatLabel.text = model?.message
            } catch let error {
                debugPrint(error)
            }
        })
        
        cell.cardView.tag = indexPath.row
        cell.cardView.addTarget(self,action: #selector(GroupChatViewController.openDetail(_:)),for: .touchUpInside)
        
        return cell
    }
    
    @objc func openDetail(_ sender: UIButton?) {
        let chat = ChatViewController()
        chat.modalPresentationStyle = .fullScreen
        let listgroup: ListGroup = groupModel.listGroup[sender!.tag]
        chat.groupName = listgroup.groupName
        chat.groupId = listgroup.groupID
        self.present(chat, animated: true, completion: nil)
        
    }
}
