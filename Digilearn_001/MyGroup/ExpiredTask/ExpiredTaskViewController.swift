//
//  ExpiredTaskViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ExpiredTaskViewController: UIViewController {
    
    var group_id = ""
    var listTaskModel: ListTaskModel!
    let date = Date()
    
    @IBOutlet weak var expiredView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ExpiredTableViewCell", bundle: nil)
        expiredView.register(nib, forCellReuseIdentifier: "expiredTaskIdentifier")
        
        expiredView.delegate = self
        expiredView.dataSource = self
        loadExpiredData()
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        loadExpiredData()
    }
    
    func loadExpiredData(){
        
        listTaskModel = nil
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/course/get_assigned_course_byIdandgrup"
        
        let parameters: [String:Any] = [
            "uid": "\(user_id)",
            "assign_group": "\(group_id)"
        ]
        
        self.showSpinner(onView: self.view)
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.listTaskModel = try decoder.decode(ListTaskModel.self, from:data)
                            
                            var taskModel: [TaskModel] = self.listTaskModel.courseByUid
                            
                            var index: Int = 0
                            for task in taskModel{
                                
                                if task.courseEnd == nil{
                                    self.listTaskModel.courseByUid.remove(at: index)
                                    index = index - 1
                                }else if task.courseEnd?.toDate()?.compare(self.date) == .orderedDescending{
                                    self.listTaskModel.courseByUid.remove(at: index)
                                    index = index - 1
                                }
                                
                                index = index + 1
                            }
                            
                            self.expiredView.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
}

extension ExpiredTaskViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTaskModel?.courseByUid.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expiredView.dequeueReusableCell(withIdentifier: "expiredTaskIdentifier") as! ExpiredTableViewCell
        
        let taskModel: TaskModel = listTaskModel.courseByUid[indexPath.row]
        
        cell.titleTask.text = taskModel.title
        cell.createdBy.text = "Created By: \(taskModel.author)"
        cell.assignBy.text = "Assigned By: \(taskModel.groupName)"
        cell.modulExpired.text = "\(taskModel.totalModule) Modules|"
        cell.topicExpired.text = "\(taskModel.totalTopic) Topics|"
        cell.activitiesExpired.text = "\(taskModel.totalAction) Activities"
        cell.totalTask.text = "\(taskModel.totalFinished)/\(taskModel.totalAction)"
        
    
        let finished = (taskModel.totalFinished as NSString).floatValue
        let total = (taskModel.totalAction as NSString).floatValue
        let progress = finished/total
        cell.progressExpired.setProgress(progress, animated: true)
        
        return cell
    }
}
