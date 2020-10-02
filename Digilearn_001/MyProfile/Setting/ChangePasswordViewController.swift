//
//  ChangePasswordViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ChangePasswordViewController: BaseSettingViewController {
    
    @IBOutlet weak var oldPassField: BottomBorderTF!
    @IBOutlet weak var newPassField: BottomBorderTF!
    @IBOutlet weak var confirmPassField: BottomBorderTF!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 18
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        let oldPass = readStringPreference(key: DigilearnsKeys.USER_PASSWORD)
        if oldPassField.text?.count ?? 0 == 0 {
            let alert = UIAlertController(title: "Change Password Failed", message: "Please filled your password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if oldPassField.text != oldPass {
            let alert = UIAlertController(title: "Change Password Failed", message: "Your old password is INCORRECT. Pelase try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if newPassField.text?.count ?? 0 < 6{
            let alert = UIAlertController(title: "Change Password Failed", message: "Password must be 6 character or more", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if confirmPassField.text?.count ?? 0 < 6{
            let alert = UIAlertController(title: "Change Password Failed", message: "Password must be 6 character or more", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if newPassField.text != confirmPassField.text {
            let alert = UIAlertController(title: "Change Password Failed", message: "Confirm password not same with new password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            changePassword(oldPassword: oldPassField.text!, newPassword: newPassField.text!)
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/api/apiupdatepassword"
        
        let parameters: [String:Any] = [
            "user_id": "\(user_id)",
            "user_password": "\(newPassword)"
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
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}
