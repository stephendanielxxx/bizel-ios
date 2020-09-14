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
        activeButton.backgroundColor = UIColor(named: "color_ B63532")
        expiredButton.backgroundColor = UIColor(named: "color_ D44444")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        debugPrint(user_id)
        
        let URL = "\(DigilearnParams.ApiUrl)/course/get_assigned_course_byId"
        
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
                            self.listTaskModel = try decoder.decode(ListTaskModel.self, from:data)
                            
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
        expiredButton.backgroundColor = UIColor(named: "color_ B63532")
        activeButton.backgroundColor = UIColor(named: "color_ D44444")
        
        listTaskModel = nil
        
        taskView.reloadData()
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
             cell.startTaskButton.titleLabel?.text = "Continue"
        }else{
             cell.startTaskButton.titleLabel?.text = "Start"
        }
       
//        cell.progressView.progress = taskModel.totalFinished/taskModel.totalAction
        
        return cell
    }
}
