//
//  ChangeEmailViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ChangeEmailViewController: BaseSettingViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 18
        
        emailField.isEnabled = false
        
//        let email = readStringPreference(key: DigilearnsKeys.EMAIL)
//        
//        emailField.text = email
        
    }
    
    func changeEmail(email: String){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/api/apiupdateemail"
        
        let parameters: [String:Any] = [
            "user_id": "\(user_id)",
            "user_email": "\(email)"
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
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        emailField.textColor = UIColor.black
        emailField.isEnabled = true
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if emailField.text?.count ?? 0 < 2 {
            showErrorAlert(title: "Change Email Failed", errorMessage: "Email too short")
        }else if !validate(emailAddress: emailField.text!){
            showErrorAlert(title: "Change Email Failed", errorMessage: "Email not valid")
        }else{
            changeEmail(email: emailField.text!)
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
