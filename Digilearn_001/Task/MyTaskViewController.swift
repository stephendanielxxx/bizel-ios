//
//  MyTaskViewController.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class MyTaskViewController: UIViewController {

    @IBOutlet weak var activeButton: UIButton!
    @IBOutlet weak var expiredButton: UIButton!
    @IBOutlet weak var taskView: UITableView!
    var listTaskModel: ListTaskModel!
    let date = Date()
    var tabShowed: Int = 0; // 0 for active, 1 for expired
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "MyTaskTableViewCell", bundle: nil)
        taskView.register(nib, forCellReuseIdentifier: "taskIdentifier")
        
        taskView.delegate = self
        taskView.dataSource = self

        activeButton.layer.cornerRadius = 15
        expiredButton.layer.cornerRadius = 15
        
        loadActiveData()

    }
    
    @IBAction func activeAction(_ sender: UIButton) {
        loadActiveData()
    }
    
    @IBAction func expiredAction(_ sender: UIButton) {
        loadExpiredData()
    }
    
    func loadActiveData(){
        tabShowed = 0
        activeButton.backgroundColor = UIColor(named: "color_ B63532")
        expiredButton.backgroundColor = UIColor(named: "color_ D44444")
        
        listTaskModel = nil
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
                
        let URL = "\(DigilearnParams.ApiUrl)/course/get_assigned_course_byId"
        
        let parameters: [String:Any] = [
            "uid": "\(user_id)"
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
                            
                            self.taskView.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    func loadExpiredData(){
        tabShowed = 1
        expiredButton.backgroundColor = UIColor(named: "color_ B63532")
        activeButton.backgroundColor = UIColor(named: "color_ D44444")
        
        listTaskModel = nil
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
                
        let URL = "\(DigilearnParams.ApiUrl)/course/get_assigned_course_byId"
        
        let parameters: [String:Any] = [
            "uid": "\(user_id)"
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
                            
                            self.taskView.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
}

extension MyTaskViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTaskModel?.courseByUid.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = taskView.dequeueReusableCell(withIdentifier: "taskIdentifier") as! MyTaskTableViewCell
        
        let taskModel: TaskModel = listTaskModel.courseByUid[indexPath.row]
        
        cell.titleLabel.text = taskModel.title
        cell.createdLabel.text = "Created By: \(taskModel.author)"
        cell.assignedLabel.text = "Assigned By: \(taskModel.groupName)"
        cell.modulesLabel.text = "\(taskModel.totalModule) Modules|"
        cell.topicsLabel.text = "\(taskModel.totalTopic) Topics|"
        cell.activitiesLabel.text = "\(taskModel.totalAction) Activities"
        cell.totalLabel.text = "\(taskModel.totalFinished)/\(taskModel.totalAction)"
        
        if(Int(taskModel.totalFinished) ?? 0 > 0){
             cell.startTaskButton.setTitle("Continue", for: .normal)
        }else{
             cell.startTaskButton.setTitle("Start", for: .normal)
        }
       
        let finished = (taskModel.totalFinished as NSString).floatValue
        let total = (taskModel.totalAction as NSString).floatValue
        let progress = finished/total
        cell.progressView.setProgress(progress, animated: true)
        
        if tabShowed == 0 {
            cell.expiredLabel.isHidden = true
            cell.startTaskButton.isHidden = false
        }else{
            cell.expiredLabel.isHidden = false
            cell.startTaskButton.isHidden = true
        }
        
        cell.startTaskButton.tag = indexPath.row
        
        cell.startTaskButton.addTarget(self, action: #selector(MyTaskViewController.openDetail(_:)), for: .touchUpInside)
        
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



extension String {
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: self)
    }
}
