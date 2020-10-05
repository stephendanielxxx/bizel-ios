//
//  EventRegistrationViewController.swift
//  Digilearn_001
//
//  Created by Teke on 05/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class EventRegistrationViewController: UIViewController {
    
    @IBOutlet weak var fullnameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneField: SkyFloatingLabelTextField!
    @IBOutlet weak var organizationField: SkyFloatingLabelTextField!
    @IBOutlet weak var positionField: SkyFloatingLabelTextField!
    @IBOutlet weak var cityField: SkyFloatingLabelTextField!
    
    var eventId = ""
    var eventName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fullname = "\(readStringPreference(key: DigilearnsKeys.FIRST_NAME)) \(readStringPreference(key: DigilearnsKeys.LAST_NAME))"
        fullnameField.text = fullname
        emailField.text = readStringPreference(key: DigilearnsKeys.EMAIL)
        phoneField.text = readStringPreference(key: DigilearnsKeys.PHONE)
        organizationField.text = readStringPreference(key: DigilearnsKeys.INSTITUT_NAME)
        positionField.text = readStringPreference(key: DigilearnsKeys.USER_POSITION)
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitEvent(_ sender: UIButton) {
        self.showSpinner(onView: self.view)
        let URL = "\(DigilearnParams.ApiUrl)/onsite/regis_onsite"
        let userId = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let parameters: [String:Any] = [
            "uid": "\(userId)",
            "event_id" : "\(eventId)",
            "event_name" : "\(eventName)",
            "fullname" : "\(fullnameField.text ?? "")",
            "email" : "\(emailField.text ?? "")",
            "hp" : "\(phoneField.text ?? "")",
            "organization" : "\(organizationField.text ?? "")",
            "position" : "\(positionField.text ?? "")",
            "city" : "\(cityField.text ?? "")",
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
                            let registerEventModel = try decoder.decode(RegisterEventModel.self, from:data)
                            
                            if(registerEventModel.code == "200"){
                                let alert = UIAlertController(title: "Event Register Success", message: "\(registerEventModel.message)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                                    self.dismiss(animated: true, completion: nil)
                                }))
                                self.present(alert, animated: true)
                            }else{
                                let alert = UIAlertController(title: "Event Register Failed", message: "\(registerEventModel.message)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
}
