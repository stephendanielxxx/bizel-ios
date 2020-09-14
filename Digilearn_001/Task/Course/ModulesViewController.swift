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
        
        loadData()
        // Do any additional setup after loading the view.
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
        
        cell.moduleLabel.text = moduleDetail.moduleName
        
        return cell
    }
}
