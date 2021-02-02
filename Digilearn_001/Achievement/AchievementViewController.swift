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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var achievementView: UITableView!
    
    var achieveModel: AchieveModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        achievementView.delegate = self
        achievementView.dataSource = self
        
        let nib = UINib(nibName: "AchievementTableViewCell", bundle: nil)
        achievementView.register(nib, forCellReuseIdentifier: "achievementIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let firstname = readStringPreference(key: DigilearnsKeys.FIRST_NAME)
        let lastname = readStringPreference(key: DigilearnsKeys.LAST_NAME)
        let username = "\(firstname) \(lastname)"
        let institut = readStringPreference(key: DigilearnsKeys.INSTITUT_NAME)
        let position = readStringPreference(key: DigilearnsKeys.USER_POSITION)
        let photo = readStringPreference(key: DigilearnsKeys.USER_PHOTO)
        
        profileImage.makeRoundedWithBorder()
        usernameLabel.text = username
        institutLabel.text = institut
        statusLabel.text = position
        profileImage.pin_updateWithProgress = true
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/member/assets.digilearn/profile/\(photo)")
        profileImage.pin_setImage(from: url)
        
        
        let URL = "\(DigilearnParams.ApiUrl)/api/apicourseach"
        let parameters: [String:Any] = [
            "user_id": "\(user_id)"
        ]
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    debugPrint(response)
                    switch response.result{
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.achieveModel = try decoder.decode(AchieveModel.self, from:data)
                            
                            if self.achieveModel.library.count > 0 {
                                self.emptyView.isHidden = true
                                self.achievementView.isHidden = false
                            }else{
                                self.emptyView.isHidden = false
                                self.achievementView.isHidden = true
                            }
                            self.achievementView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                            self.emptyView.isHidden = false
                            self.achievementView.isHidden = true
                        }
                    case .failure(_):
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
        return achieveModel?.library.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = achievementView.dequeueReusableCell(withIdentifier: "achievementIdentifier") as! AchievementTableViewCell
        let achieve: Library = (achieveModel?.library[indexPath.row])!
        cell.titleTask.text = achieve.courseName
        cell.namaInstitut.text = achieve.institutName
        
        
        cell.achieveDetail.tag = indexPath.row
        cell.achieveDetail.addTarget(self,action: #selector(AchievementViewController.openDetail(_:)),for: .touchUpInside)
        return cell
    }
    
    @objc func openDetail(_ sender: UIButton?) {
        
        let achieveDetail = AchievementDetailViewController()
        achieveDetail.modalPresentationStyle = .fullScreen
        let library: Library = achieveModel.library[sender!.tag]
        achieveDetail.titleachieve = library.courseName ?? ""
        achieveDetail.image = library.courseImage ?? ""
        achieveDetail.institutname = library.institutName
        achieveDetail.courseid = library.courseID
        self.present(achieveDetail, animated: true, completion: nil)
    }
    
}
