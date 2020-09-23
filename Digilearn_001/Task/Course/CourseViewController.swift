//
//  CourseViewController.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire


class CourseViewController: UIViewController {

    var course_id = ""
    var course_name = ""
    var created_by = ""
    var course_about = ""
    
    var listCourseModel: ListCourseModel!
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseCreatedBy: UILabel!
    @IBOutlet weak var courseImage: UIImageView!
    @IBOutlet weak var tabContent: UIView!
    @IBOutlet weak var modulesButton: UIButton!
    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var modulesLine: UIView!
    @IBOutlet weak var aboutLine: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitial()
        loadData()
    }
    
    func setInitial(){
        let modules = ModulesViewController()
        modules.course_id = course_id
        embed(modules, inParent: self, inView: tabContent)
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/course/get_detail/\(course_id)/\(user_id)"
        
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
                            self.listCourseModel = try decoder.decode(ListCourseModel.self, from:data)
                            
                            self.courseTitle.text = self.course_name
                            self.courseCreatedBy.text = "Created by \(self.created_by)"
                            
                            self.courseImage.pin_updateWithProgress = true
                            self.courseImage.contentMode = .scaleToFill
                            self.courseImage.clipsToBounds = true
                            
                            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/course/image/\(self.listCourseModel.courseImage)")!
                    
                            self.courseImage.pin_setImage(from: url)
//                            self.taskView.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    @IBAction func aboutAction(_ sender: UIButton) {
        
        aboutLine.backgroundColor = UIColor(named: "red_1")
        modulesLine.backgroundColor = UIColor.white
        
        aboutButton.setTitleColor(UIColor(named: "red_1"), for: .normal)
        modulesButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        let about = AboutCourseViewController()
        about.course_about = course_about
        embed(about, inParent: self, inView: tabContent)
    }
    
    @IBAction func moduleAction(_ sender: UIButton) {
        
        modulesLine.backgroundColor = UIColor(named: "red_1")
        aboutLine.backgroundColor = UIColor.white
        
        modulesButton.setTitleColor(UIColor(named: "red_1"), for: .normal)
        aboutButton.setTitleColor(UIColor.lightGray, for: .normal)
        
        let modules = ModulesViewController()
        modules.course_id = course_id
        embed(modules, inParent: self, inView: tabContent)
    }

}

extension UIViewController{
    func embed(_ viewController:UIViewController, inParent controller:UIViewController, inView view:UIView){
       viewController.willMove(toParent: controller)
       viewController.view.frame = view.bounds
       view.addSubview(viewController.view)
       controller.addChild(viewController)
       viewController.didMove(toParent: controller)
    }
}
