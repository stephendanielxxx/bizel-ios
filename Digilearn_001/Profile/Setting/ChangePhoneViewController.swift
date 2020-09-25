//
//  ChangePhoneViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ChangePhoneViewController: BaseSettingViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var phoneView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.layer.cornerRadius = 18
        
//        let phone = readStringPreference(key: DigilearnsKeys.PHONE)
//
//        phoneView.text = phone
    }
    
    func changePhone(phone: String){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/api/apiupdatephone"
        
        let parameters: [String:Any] = [
            "user_id": "\(user_id)",
            "user_phone": "\(phone)"
        ]
        self.showSpinner(onView: self.view)
        AF.request(URL,
                   method: .put,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            let response = try decoder.decode(ChangeProfileModel.self, from:data)
                            
                            self.showErrorAlert(title: response.info, errorMessage: response.message)
                            
                            if response.info.caseInsensitiveCompare("Updated Failed") != .orderedSame {
                                self.logout()
                            }
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if phoneView.text?.count ?? 0 < 5{
            showErrorAlert(title: "Change Phone Failed", errorMessage: "Phone not valid")
        }else {
            changePhone(phone: phoneView.text!)
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
