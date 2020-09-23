//
//  ModulesViewController.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ModulesViewController: UIViewController {

    var listCourseModel: ListCourseModel!
    @IBOutlet weak var moduleView: UITableView!
    @IBOutlet weak var refresh: UILabel!
    var course_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "ModulesTableViewCell", bundle: nil)
        moduleView.register(nib, forCellReuseIdentifier: "moduleIdentifier")
               
        moduleView.delegate = self
        moduleView.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
            let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
            let URL = "\(DigilearnParams.ApiUrl)/course/get_detail/\(course_id)/\(user_id)"
            
            AF.request(URL,
                       method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default).responseData { response in
                        switch response.result {
                        case .success(let data):
                            self.removeSpinner()
                            let decoder = JSONDecoder()
                            do{
                               
                                self.listCourseModel = try decoder.decode(ListCourseModel.self, from:data)
                                
                                self.moduleView.reloadData()
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(let error):
                            self.removeSpinner()
                        }
            }
        }

    @IBAction func refresh(_ sender: UIButton) {
        loadData()
    }
}

extension ModulesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCourseModel?.moduleDetail.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = moduleView.dequeueReusableCell(withIdentifier: "moduleIdentifier") as! ModulesTableViewCell
        
        let moduleDetail: ModuleDetail = listCourseModel.moduleDetail[indexPath.row]
        
        if moduleDetail.moduleFinish == "finish"{
            cell.moduleLabel.textColor = UIColor.black
        }else{
            cell.moduleLabel.textColor = UIColor.lightGray
        }
        
        cell.moduleLabel.text = moduleDetail.moduleName
        
        cell.cardView.tag = indexPath.row
        
        cell.cardView.addTarget(self, action: #selector(ModulesViewController.openDetail(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func openDetail(_ sender: UIButton?) {
        let index = sender!.tag
        let task = listCourseModel.moduleDetail[index]
        let count = listCourseModel.moduleDetail.count
        
        let topic = TopicViewController()
        
        topic.moduleImage = task.moduleImage
        topic.moduleAuthor = task.courseAuthor
        topic.moduleTitle = task.moduleName
        topic.moduleDesc = task.moduleDesc
        topic.moduleId = task.moduleID
        topic.courseId = course_id
        
        if count == 1 {
            topic.nextModuleName = ""
        }else if index < count {
            debugPrint(index)
            debugPrint(count)
            topic.nextModuleName = listCourseModel.moduleDetail[index+1].moduleName
        }else{
            topic.nextModuleName = ""
        }
        
        topic.modalPresentationStyle = .fullScreen
        
        if task.courseAccess.caseInsensitiveCompare("Random") == .orderedSame{
            self.present(topic, animated: true, completion: nil)
        }else{
            if index > 0 {
                let taskBefore =
                    listCourseModel.moduleDetail[sender!.tag - 1]
                
                if(taskBefore.moduleFinish.caseInsensitiveCompare("Finish") == .orderedSame){
                    self.present(topic, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "", message: "You can't open this module. Please finish the previous module in order.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }else{
                self.present(topic, animated: true, completion: nil)
            }
        }
    }
}
