//
//  MemberGroupViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 18/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire


class MemberGroupViewController: UIViewController {
    
    
    @IBOutlet weak var memberView: UITableView!
    @IBOutlet weak var clickRefreshButton: UIButton!
    
    var group_id = ""
    var memberModel: MemberModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        memberView.delegate = self
        memberView.dataSource = self
        let nib = UINib(nibName: "IsiMemberTableViewCell", bundle: nil)
        memberView.register(nib, forCellReuseIdentifier: "IsiIdentifier")
        
        loadData()
        
    }
    @IBAction func refreshAction(_ sender: UIButton) {
        loadData()
    }
    
    func loadData() {
        self.showSpinner(onView: view)
        let URL = "\(DigilearnParams.ApiUrl)/api/apimembergroup"
        let parameters: [String:Any] = [
            "group_id": "\(group_id)"
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
                            self.memberModel = try decoder.decode(MemberModel.self, from:data)
                            self.memberView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
}
extension MemberGroupViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberModel?.membergroup.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  memberView.dequeueReusableCell(withIdentifier: "IsiIdentifier") as! IsiMemberTableViewCell
        let member: Membergroup = (memberModel?.membergroup[indexPath.row])!
        var username = ""
        if member.userFirstName != nil {
            username = "\(member.userFirstName!)"
        }
        if member.userLastName != nil {
            username = "\(username) \(member.userLastName!)"
        }
        cell.namaMember.text = username
        cell.namaInstitusi.text = member.institutName
        
        if member.memberStatus == "1" {
            cell.statusMember.text = "Learner"
            cell.statusMember.textColor = UIColor(named: "color_4283B8")
        }
        else {
            cell.statusMember.text = "Admin"
            cell.statusMember.textColor = UIColor.red
        }
        return cell
        
    }
}

