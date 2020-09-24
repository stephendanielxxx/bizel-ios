//
//  ProfileViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var optionMenu: UIBarButtonItem!
    var dropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discardButton.layer.cornerRadius = 18
        saveButton.layer.cornerRadius = 18
        
        dropDown = DropDown()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = optionMenu // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Contact Us", "Privacy Policy", "Settings", "Logout"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch index {
            case 0:
                let contact = ContactUsViewController()
                contact.modalPresentationStyle = .fullScreen
                self.present(contact, animated: true, completion: nil)
                break
            case 1:
                let privacy = PrivacyViewController()
                privacy.modalPresentationStyle = .fullScreen
                self.present(privacy, animated: true, completion: nil)
                
                break
            case 2:
                break
            case 3:
                self.logout()
                break
            default:
                break
            }
        }
        
        dropDown.width = 200
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
    
    @IBAction func optionAction(_ sender: UIBarButtonItem) {
        dropDown.show()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
}
