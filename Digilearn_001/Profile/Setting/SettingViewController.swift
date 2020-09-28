//
//  SettingViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import PopupDialog
import Alamofire

class SettingViewController: BaseSettingViewController {
    
    @IBOutlet weak var changePassword: UILabel!
    @IBOutlet weak var changePhone: UILabel!
    @IBOutlet weak var changeEmail: UILabel!
    @IBOutlet weak var deleteAccount: UILabel!
    @IBOutlet weak var notificationSwitch: UISwitch!
    
    var delegate: SettingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let changePass = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.openChangePassword))
        changePassword.isUserInteractionEnabled = true
        changePassword.addGestureRecognizer(changePass)
        
        let changePhoneGesture = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.openChangePhone))
        changePhone.isUserInteractionEnabled = true
        changePhone.addGestureRecognizer(changePhoneGesture)
        
        let changeEmailGesture = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.openChangeEmail))
        changeEmail.isUserInteractionEnabled = true
        changeEmail.addGestureRecognizer(changeEmailGesture)
        
        let deleteAccountGesture = UITapGestureRecognizer(target: self, action: #selector(SettingViewController.openDeleteAccount))
        deleteAccount.isUserInteractionEnabled = true
        deleteAccount.addGestureRecognizer(deleteAccountGesture)
        
        let userNotif = readStringPreference(key: DigilearnsKeys.USER_NOTIFICATION)
        
        if userNotif == "true" {
            notificationSwitch.isOn = true
        }else {
            notificationSwitch.isOn = false
        }
        
        notificationSwitch.addTarget(self, action: #selector(valueChange), for:UIControl.Event.valueChanged)

    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func openChangePassword(sender:UITapGestureRecognizer) {
        let changePass = ChangePasswordViewController()
        
        changePass.modalPresentationStyle = .fullScreen
        
        self.present(changePass, animated: true, completion: nil)
    }
    
    @objc func openChangePhone(sender:UITapGestureRecognizer) {
        let changePhone = ChangePhoneViewController()
        
        changePhone.modalPresentationStyle = .fullScreen
        
        self.present(changePhone, animated: true, completion: nil)
    }
    
    @objc func openChangeEmail(sender:UITapGestureRecognizer) {
        let changeEmail = ChangeEmailViewController()
        
        changeEmail.modalPresentationStyle = .fullScreen
        
        self.present(changeEmail, animated: true, completion: nil)
    }
    
    @objc func openDeleteAccount(sender:UITapGestureRecognizer) {
        showCustomDialog(animated: true)
        
    }
    
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let ratingVC = DeleteDialogViewController(nibName: "DeleteDialogViewController", bundle: nil)
        ratingVC.delegate = self
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC,
                                buttonAlignment: .horizontal,
                                transitionStyle: .bounceDown,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        present(popup, animated: animated, completion: nil)
    }
    
    @objc func valueChange(mySwitch: UISwitch) {
        let value = mySwitch.isOn
        // Do something
        setUserNotification(isOn: value)
    }
    
    func setUserNotification(isOn: Bool){
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        let URL = "\(DigilearnParams.ApiUrl)/user/auth/status_notification"
        
        var status = "false"
        if isOn{
            status = "true"
        }
        
        let parameters: [String:Any] = [
            "userid": "\(user_id)",
            "status": "\(status)"
        ]
        
        self.showSpinner(onView: self.view)
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    
                    debugPrint(response)
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            let response = try decoder.decode(NotificationModel.self, from:data)
                            if response.status.caseInsensitiveCompare("success") == .orderedSame {
                                if isOn {
                                    self.saveStringPreference(value: "true", key: DigilearnsKeys.USER_NOTIFICATION)
                                }else{
                                    self.saveStringPreference(value: "false", key: DigilearnsKeys.USER_NOTIFICATION)
                                }
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
}

extension SettingViewController: DeleteDialogDelegate{
    func onDeleteAccount(){
        delegate.onLogout()
    }
}

protocol SettingDelegate {
    func onLogout()
}
