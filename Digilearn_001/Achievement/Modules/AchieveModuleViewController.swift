//
//  AchieveModuleViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 29/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class AchieveModuleViewController: UIViewController {
    @IBOutlet weak var listModule: UITableView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var course_id = ""
    var modulesModel: ModulesModel!
    var achieveModel: AchieveModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listModule.delegate = self
        listModule.dataSource = self
        
        let nib = UINib(nibName: "AchieveModuleTableViewCell", bundle: nil)
        listModule.register(nib, forCellReuseIdentifier: "modulesIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/api/apicourselistmoduleach"
        let parameters: [String:Any] = [
            "course_id": "\(course_id)",
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
                            self.modulesModel = try decoder.decode(ModulesModel.self, from:data)
                            debugPrint(self.modulesModel)
                            self.listModule.reloadData()
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
extension AchieveModuleViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modulesModel?.courseListModule.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listModule.dequeueReusableCell(withIdentifier: "modulesIdentifier") as! AchieveModuleTableViewCell
        let course: CourseListModule = (modulesModel?.courseListModule[indexPath.row])!
        cell.courseName.text = course.moduleName
        
        
        cell.isiModule.tag = indexPath.row
        cell.isiModule.addTarget(self,action: #selector(AchievementViewController.openDetail(_:)),for: .touchUpInside)
        return cell
    }
    
    @objc func openDetail(_ sender: UIButton?) {
        debugPrint("test")
        let isiModule = ModuleDetailViewController()
    isiModule.modalPresentationStyle = .fullScreen
   // let library: Library = achieveModel.Library[sender!.tag]
//    isiModule.module_name = library.courseName
  //  isiModule.module_image = library.courseImage
   // isiModule.institute_name = library.institutName
    //isiModule.course_id = library.courseID
   // self.present(isiModule, animated: true, completion: nil)
}

}


