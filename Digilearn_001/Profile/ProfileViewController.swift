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

class ProfileViewController: BaseSettingViewController {
    
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var optionMenu: UIBarButtonItem!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var changeProfile: UIButton!
    @IBOutlet weak var firstNameField: BottomBorderTF!
    @IBOutlet weak var lastNameField: BottomBorderTF!
    @IBOutlet weak var nickNameField: BottomBorderTF!
    @IBOutlet weak var emailField: BottomBorderTF!
    @IBOutlet weak var phoneField: BottomBorderTF!
    @IBOutlet weak var institutionField: BottomBorderTF!
    @IBOutlet weak var positionField: BottomBorderTF!
    
    var dropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discardButton.layer.cornerRadius = 18
        saveButton.layer.cornerRadius = 18
        
        showData()
    }
    
    func showData(){
        let firstName = readStringPreference(key: DigilearnsKeys.FIRST_NAME)
        let lastName = readStringPreference(key: DigilearnsKeys.LAST_NAME)
        let nickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
        let email = readStringPreference(key: DigilearnsKeys.EMAIL)
        let phone = readStringPreference(key: DigilearnsKeys.PHONE)
        let institution = readStringPreference(key: DigilearnsKeys.INSTITUT_NAME)
        let position = readStringPreference(key: DigilearnsKeys.USER_POSITION)
        let image = readStringPreference(key: DigilearnsKeys.USER_PHOTO)
        
        firstNameField.text = firstName
        lastNameField.text = lastName
        nickNameField.text = nickName
        emailField.text = email
        phoneField.text = phone
        institutionField.text = institution
        positionField.text = position
        
        firstNameField.isEnabled = false
        lastNameField.isEnabled = false
        nickNameField.isEnabled = false
        emailField.isEnabled = false
        phoneField.isEnabled = false
        institutionField.isEnabled = false
        positionField.isEnabled = false
        
       let url = Foundation.URL(string: "https://digicourse.id/digilearn/member/assets.digilearn/profile/\(image)")
        
        profileImage.pin_setImage(from: url)
        
        profileImage.makeRounded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
                let setting = SettingViewController()
                setting.modalPresentationStyle = .fullScreen
                self.present(setting, animated: true, completion: nil)
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
    
    @IBAction func changeAction(_ sender: UIButton) {
        
        changeImageButton.isHidden = false
        
        firstNameField.isEnabled = true
        lastNameField.isEnabled = true
        nickNameField.isEnabled = true
        
        firstNameField.textColor = UIColor.black
        lastNameField.textColor = UIColor.black
        nickNameField.textColor = UIColor.black
    }
    
    @IBAction func optionAction(_ sender: UIBarButtonItem) {
        dropDown.show()
    }
    
    @IBAction func discardAction(_ sender: UIButton) {
        
        changeImageButton.isHidden = true
        
        firstNameField.isEnabled = false
        lastNameField.isEnabled = false
        nickNameField.isEnabled = false
        
        firstNameField.textColor = UIColor.lightGray
        lastNameField.textColor = UIColor.lightGray
        nickNameField.textColor = UIColor.lightGray
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
     
}
