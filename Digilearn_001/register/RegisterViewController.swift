//
//  RegisterViewController.swift
//  Digilearn_001
//
//  Created by Teke on 04/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTF: BottomBorderTF!
    @IBOutlet weak var lastNameTF: BottomBorderTF!
    @IBOutlet weak var nickNameTF: BottomBorderTF!
    @IBOutlet weak var phoneTF: FPNTextField!
    @IBOutlet weak var emailTF: BottomBorderTF!
    @IBOutlet weak var passwordTF: BottomBorderTF!
    @IBOutlet weak var confirmPasswordTF: BottomBorderTF!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstNameTF.placeholder = "first name"
        lastNameTF.placeholder = "last name"
        nickNameTF.placeholder = "nick name"
        phoneTF.placeholder = "Input phone number"
        emailTF.placeholder = "email"
        passwordTF.placeholder = "password"
        confirmPasswordTF.placeholder = "confirm password"
        
        firstNameTF.font = .systemFont(ofSize: 14)
        lastNameTF.font = .systemFont(ofSize: 14)
        nickNameTF.font = .systemFont(ofSize: 14)
        phoneTF.font = .systemFont(ofSize: 14)
        emailTF.font = .systemFont(ofSize: 14)
        passwordTF.font = .systemFont(ofSize: 14)
        confirmPasswordTF.font = .systemFont(ofSize: 14)
        
        phoneTF.setFlag(key: .ID)
       
    }

}

class BottomBorderTF: UITextField {

    var bottomBorder = UIView()
    override func awakeFromNib() {

        //MARK: Setup Bottom-Border
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        //Mark: Setup Anchors
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
       }
}

class PhoneBottomBorderTF: FPNTextField {
    var bottomBorder = UIView()
    override func awakeFromNib() {

        //MARK: Setup Bottom-Border
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        bottomBorder.backgroundColor = UIColor.lightGray
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBorder)
        //Mark: Setup Anchors
        bottomBorder.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bottomBorder.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomBorder.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true // Set Border-Strength
       }
}
