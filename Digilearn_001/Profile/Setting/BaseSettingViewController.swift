//
//  BaseSettingViewController.swift
//  Digilearn_001
//
//  Created by Teke on 25/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class BaseSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showErrorAlert(title: String, errorMessage: String){
        let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showErrorAlert(title: String, errorMessage: String, handler:((UIAlertAction) -> Void)?){
           let alert = UIAlertController(title: title, message: errorMessage, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Close", style: .default, handler: handler))
           self.present(alert, animated: true)
       }
    
    func logout(){
        let user_email = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/user/auth/logout"
        
        let parameters: [String:Any] = [
            "email": "\(user_email)"
        ]
        
        self.showSpinner(onView: self.view)
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            let logoutModel = try decoder.decode(LogoutModel.self, from:data)
                            
                            self.saveStringPreference(value: "", key: DigilearnsKeys.USER_ID)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.FIRST_NAME)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.LAST_NAME)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.USER_NICK)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.EMAIL)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.PHONE)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.INSTITUT_NAME)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.USER_POSITION)
                            self.saveStringPreference(value: "", key: DigilearnsKeys.USER_PHOTO)
                            
//                            self.resetDefaults()
                            
                            self.dismiss(animated: true, completion: {
                                let login = LoginViewController()
                                login.modalPresentationStyle = .fullScreen
                                self.present(login, animated: true, completion: nil)
                            })
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
