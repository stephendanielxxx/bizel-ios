//
//  DetailtopicViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 01/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class DetailtopicViewController: UIViewController {
    @IBOutlet weak var isiDetailtopic: UITextView!
    
    var module_id = ""
    var detailtopicModel: DetailtopicModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint(module_id)
        let URL = "\(DigilearnParams.ApiUrl)/api/apimoduledetail"
        let parameters: [String:Any] = [
            "module_id": "\(module_id)"
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
                            self.detailtopicModel = try decoder.decode(DetailtopicModel.self, from:data)
                            self.isiDetailtopic.attributedText = self.detailtopicModel.moduleDetailAchievement[0].moduleDescription.htmlToAttributedString
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
}









