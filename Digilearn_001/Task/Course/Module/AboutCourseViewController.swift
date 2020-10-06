//
//  AboutCourseViewController.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class AboutCourseViewController: UIViewController {
    
    var course_about = ""
    var courseId = ""
    
    @IBOutlet weak var courseDetail: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if course_about.isEmpty {
            loadData()
        }else{
            courseDetail.attributedText = course_about.htmlToAttributedString
        }
    }
    
    func loadData(){
        let URL = "\(DigilearnParams.ApiUrl)/api/apicoursedetail"
        
        let parameters: [String:Any] = [
            "course_id": "\(courseId)"
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
                            let courseDetailModel = try decoder.decode(CourseDetailModel.self, from:data)
                            self.courseDetail.attributedText = courseDetailModel.course_detail[0].course_description?.htmlToAttributedString
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
}
