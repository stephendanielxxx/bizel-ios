//
//  SettingViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import PopupDialog

class SettingViewController: BaseSettingViewController {
    
    @IBOutlet weak var changePassword: UILabel!
    @IBOutlet weak var changePhone: UILabel!
    @IBOutlet weak var changeEmail: UILabel!
    @IBOutlet weak var deleteAccount: UILabel!
    
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
    
}

extension SettingViewController: DeleteDialogDelegate{
    func onDeleteAccount(){
        delegate.onLogout()
    }
}

protocol SettingDelegate {
    func onLogout()
}
