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
import Toast_Swift

class ProfileViewController: BaseSettingViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    var imagePicker = UIImagePickerController()
    
    var dropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discardButton.layer.cornerRadius = 18
        saveButton.layer.cornerRadius = 18
     
        setTapToHideKeyboard()
        
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
        
        profileImage.makeRoundedWithBorder()
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
                setting.delegate = self
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
        imagupload()
        showToast(message: "Update data success!")
        
        firstNameField.isEnabled = false
        lastNameField.isEnabled = false
        nickNameField.isEnabled = false
        
        firstNameField.textColor = UIColor.lightGray
        lastNameField.textColor = UIColor.lightGray
        nickNameField.textColor = UIColor.lightGray
        
    }
    func showToast(message: String) {
           var style = ToastStyle()
           style.backgroundColor = UIColor.darkGray
           style.messageColor = UIColor.white
           ToastManager.shared.style = style
           
           self.view.makeToast(message)
       }
    
    @IBAction func openImagePicker(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = image
        }
        
    }
    
    func imagupload(){
        
        self.showSpinner(onView: self.view)
        
        let firstName = firstNameField.text
        let lastName = lastNameField.text
        let nickName = nickNameField.text
        let phone = phoneField.text
        let uid = readStringPreference(key: DigilearnsKeys.USER_ID)
        let upload_file = profileImage.image
        
        var parameters = [String:AnyObject]()
        parameters = ["uid":uid,
                      "phone":phone!,
                      "firstName":firstName!,
                      "lastName":lastName!,
                      "nickname":nickName!,
                      "image": upload_file!] as [String : AnyObject]
        
        let URL = "\(DigilearnParams.ApiUrl)/user/auth/uploadPic"
        
        uploadImage(endUrl: URL, imageData: profileImage.image!.jpegData(compressionQuality: 0.6), parameters: parameters)
    }
    
    
    func uploadImage(endUrl: String, imageData: Data?, parameters: [String : Any], onCompletion: ((_ isSuccess:Bool) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
        
        let headers: HTTPHeaders = [
            
            "Content-type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "image", fileName: "\(Date.init().timeIntervalSince1970).jpg", mimeType: "image/jpg")
            }
        },
                  to: endUrl, method: .post , headers: headers)
            .responseData { response in
                
                switch response.result {
                case .success(let data):
                    self.removeSpinner()
                    let decoder = JSONDecoder()
                    do{
                        let uploadImageModel = try decoder.decode(UploadModel.self, from:data)
                        self.saveStringPreference(value: uploadImageModel.new_image!, key: DigilearnsKeys.USER_PHOTO)
                        self.saveStringPreference(value: self.firstNameField.text!, key: DigilearnsKeys.FIRST_NAME)
                        self.saveStringPreference(value: self.lastNameField.text!, key: DigilearnsKeys.LAST_NAME)
                        self.saveStringPreference(value: self.nickNameField.text!, key: DigilearnsKeys.USER_NICK)
                    }catch{
                        print(error.localizedDescription)
                    }
                case .failure(_):
                    self.removeSpinner()
                }
        }
    }
}

extension ProfileViewController: SettingDelegate{
    func onLogout(){
    
        deleteAccount()
        
    }
    
    func deleteAccount(){
            let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
            
            let URL = "\(DigilearnParams.ApiUrl)/api/apidelete"
            
            let parameters: [String:Any] = [
                "user_id": "\(user_id)"
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
                                _ = try decoder.decode(ChangeProfileModel.self, from:data)
                                self.logout()
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(_):
                            self.removeSpinner()
                        }
            }
        }
}
