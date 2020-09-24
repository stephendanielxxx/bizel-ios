//
//  ActiveTaskViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ActiveTaskViewController: UIViewController {
    
    @IBOutlet weak var clickButton: UIButton!
    @IBOutlet weak var activeView: UITableView!
    var group_id = ""
    var listTaskModel: ListTaskModel!
    let date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "ActiveTaskTableViewCell", bundle: nil)
        activeView.register(nib, forCellReuseIdentifier: "activeTaskIdentifier")
        
        activeView.delegate = self
        activeView.dataSource = self
        loadActiveData()
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        loadActiveData()
    }
    
    func loadActiveData(){
        
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
                            
                            let taskModel: [TaskModel] = self.listTaskModel.courseByUid
                            
                            var index: Int = 0
                            for task in taskModel{
                                if task.courseEnd != nil{
                                    if task.courseEnd?.toDate()?.compare(self.date) == .orderedAscending{
                                        self.listTaskModel.courseByUid.remove(at: index)
                                        index = index - 1
                                    }
                                }
                                
                                index = index + 1
                            }
                            
                            debugPrint(self.listTaskModel)
                            
                            self.activeView.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
}

extension ActiveTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTaskModel?.courseByUid.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = activeView.dequeueReusableCell(withIdentifier: "activeTaskIdentifier") as! ActiveTaskTableViewCell
        
        let taskModel: TaskModel = (listTaskModel?.courseByUid[indexPath.row])!
        
        cell.titleTask.text = taskModel.title
        cell.createdBy.text = "Created By: \(taskModel.author)"
        cell.assignBy.text = "Assigned By: \(taskModel.groupName)"
        cell.modulTask.text = "\(taskModel.totalModule) Modules|"
        cell.topicTask.text = "\(taskModel.totalTopic) Topics|"
        cell.activitiesTask.text = "\(taskModel.totalAction) Activities"
        cell.totalTask.text = "\(taskModel.totalFinished)/\(taskModel.totalAction)"
        
        if(Int(taskModel.totalFinished) ?? 0 > 0){
            cell.startButton.setTitle("Continue", for: .normal)
        }else{
            cell.startButton.setTitle("Start", for: .normal)
        }
        
        let finished = (taskModel.totalFinished as NSString).floatValue
        let total = (taskModel.totalAction as NSString).floatValue
        let progress = finished/total
        cell.progressView.setProgress(progress, animated: true)
        
        //        if taskModel.courseEnd != nil {
        //            cell.expiredLabel.text = "Until : \(taskModel.courseEnd!)"
        //        }else{
        //            cell.expiredLabel.text = ""
        //        }
        
        cell.startButton.tag = indexPath.row
        
        cell.startButton.addTarget(self, action: #selector(ActiveTaskViewController.openDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func openDetail(_ sender: UIButton?) {
        let course = CourseViewController()
        
        course.modalPresentationStyle = .fullScreen
        
        let task = listTaskModel.courseByUid[sender!.tag]
        
        course.course_id = task.id
        course.course_name = task.title
        course.created_by = task.author
        course.course_about = task.detail
        
        self.present(course, animated: true, completion: nil)
    }
}
