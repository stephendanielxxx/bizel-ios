//
//  DetailViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 28/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    @IBOutlet weak var isiDetail: UITextView!
    
    var course_id = ""
    var detailModel: DetailModel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

                debugPrint(course_id)
                let URL = "\(DigilearnParams.ApiUrl)/api/apicoursedetail"
                let parameters: [String:Any] = [
                    "course_id": "\(course_id)"
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
                                    self.detailModel = try decoder.decode(DetailModel.self, from:data)
                                    self.isiDetail.attributedText = self.detailModel.courseDetail[0].courseDescription.htmlToAttributedString
                                }catch{
                                    print(error.localizedDescription)
                                }
                            case .failure(_):
                                self.removeSpinner()
                            }
                }
            
            }
            
        }
         
