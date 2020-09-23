//
//  AchievementViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Reqres
import PINRemoteImage

class AchievementViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var institutLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var achievementView: UITableView!
    
    var achievementModel: AchievementModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        achievementView.delegate = self
        achievementView.dataSource = self
        
        let nib = UINib(nibName: "AchievementTableViewCell", bundle: nil)
        achievementView.register(nib, forCellReuseIdentifier: "achievementIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/api/apicourseach"
        let parameters: [String:Any] = [
            "uid": "\(user_id)"
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
                            self.achievementModel = try decoder.decode(AchievementModel.self, from:data)
                            self.achievementView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AchievementViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievementModel?.achievement.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = achievementView.dequeueReusableCell(withIdentifier: "achievementIdentifier") as! AchievementTableViewCell
        let achievement: Achievement = (achievementModel?.achievement[indexPath.row])!
        cell.titleTask.text = achievement.courseName
        
        
        return cell
    }
}




