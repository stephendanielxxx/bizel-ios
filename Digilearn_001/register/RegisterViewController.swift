//
//  RegisterViewController.swift
//  Digilearn_001
//
//  Created by Teke on 04/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import SimpleCheckbox
import Alamofire

class RegisterViewController: UIViewController {
    
    let URL = "\(DigilearnParams.ApiUrl)/user/auth/create_user"

    @IBOutlet weak var firstNameTF: BottomBorderTF!
    @IBOutlet weak var lastNameTF: BottomBorderTF!
    @IBOutlet weak var nickNameTF: BottomBorderTF!
    @IBOutlet weak var phoneTF: FPNTextField!
    @IBOutlet weak var emailTF: BottomBorderTF!
    @IBOutlet weak var passwordTF: BottomBorderTF!
    @IBOutlet weak var confirmPasswordTF: BottomBorderTF!
    @IBOutlet weak var tosCheckBox: Checkbox!
    @IBOutlet weak var privacyLbl: UILabel!
    @IBOutlet weak var passwordToggle: UIButton!
    @IBOutlet weak var confirmPasswordToggle: UIButton!
    
    var phoneValid = false;
    var passClick = true
    var confirmPassClick = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneTF.delegate = self
        
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
        
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
        
        phoneTF.setFlag(key: .ID)
        
        tosCheckBox.borderStyle = .square
        tosCheckBox.uncheckedBorderColor = UIColor.lightGray
        tosCheckBox.checkedBorderColor = UIColor.lightGray
        tosCheckBox.checkmarkColor = UIColor.lightGray
        tosCheckBox.checkmarkStyle = .tick
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.privacyFunction))
        privacyLbl.isUserInteractionEnabled = true
        privacyLbl.addGestureRecognizer(tap)
       
    }

     @objc func privacyFunction(sender:UITapGestureRecognizer) {
            let privacy = PrivacyViewController()

            privacy.modalPresentationStyle = .fullScreen
          
            self.present(privacy, animated: true, completion: nil)
     }
    
    @IBAction func passwordToggleClick(_ sender: UIButton) {
        if(passClick == true) {
                   passwordTF.isSecureTextEntry = false
                   passwordToggle.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)

               } else {
                   passwordTF.isSecureTextEntry = true
                   passwordToggle.setImage(UIImage(systemName: "eye.fill"), for: .normal)
               }

               passClick = !passClick
    }
    
    @IBAction func confirmPasswordToggleClick(_ sender: UIButton) {
        if(confirmPassClick == true) {
                   confirmPasswordTF.isSecureTextEntry = false
                   confirmPasswordToggle.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)

               } else {
                   confirmPasswordTF.isSecureTextEntry = true
                   confirmPasswordToggle.setImage(UIImage(systemName: "eye.fill"), for: .normal)
               }

               confirmPassClick = !confirmPassClick
    }
    
    @IBAction func openHelp(_ sender: UIButton) {
          let faq = FaqViewController()

          faq.modalPresentationStyle = .fullScreen
        
          self.present(faq, animated: true, completion: nil)
    }
    
    @IBAction func backToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: UIButton) {
        var pass = passwordTF.text
        var confirmPass = confirmPasswordTF.text
        var firstName = firstNameTF.text
        var lastName = lastNameTF.text
        var nickName = nickNameTF.text
        var email = emailTF.text
        
        var phone = phoneTF.getFormattedPhoneNumber(format: .E164)
        
        phone = phone?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        var passCounter = pass?.count ?? 0
        var phoneCounter = phoneTF.text?.count ?? 1
        
        if(firstName?.isEmpty ?? true){
            let alert = UIAlertController(title: "Register Failed", message: "Please fill in your data first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(lastName?.isEmpty ?? true){
            let alert = UIAlertController(title: "Register Failed", message: "Please fill in your data first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(nickName?.isEmpty ?? true){
            let alert = UIAlertController(title: "Register Failed", message: "Please fill in your data first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(!phoneValid){
            let alert = UIAlertController(title: "Register Failed", message: "Invalid phone number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(passCounter < 6){
            let alert = UIAlertController(title: "Register Failed", message: "Password must be at least 6 characters", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(pass != confirmPass){
            let alert = UIAlertController(title: "Register Failed", message: "Confirm password INCORRECT", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(!tosCheckBox.isChecked){
            let alert = UIAlertController(title: "Register Failed", message: "Please read and check the Terms of Service and Privacy Policy before register", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            self.showSpinner(onView: self.view)
            
            let parameters: [String:Any] = [
                        "phone": "\(phone!)",
                        "fname": "\(firstName!)",
                        "lname" : "\(lastName!)",
                        "nickname" : "\(nickName!)",
                        "password" : "\(pass!)",
                        "email" : "\(email!)"
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
                     let registerModel = try decoder.decode(RegisterModel.self, from:data)
                     if(registerModel.code == "200"){
                        let alert = UIAlertController(title: "Register Success", message: "Register success. Please check your email for confirmation.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default){ (action:UIAlertAction!) in
                                self.dismiss(animated: true, completion: nil)
                            })
                        self.present(alert, animated: true)
                     }else{
                         let alert = UIAlertController(title: "Register Failed", message: "\(registerModel.message)", preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                         self.present(alert, animated: true)
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

extension RegisterViewController: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if(!isValid){
            phoneValid = false
        }else{
            phoneValid = true
        }
    }
    
    func fpnDisplayCountryList() {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // I try this one
        if string == "0" {
            if textField.text!.count == 0 {
                return false
            }
        }
        return true
    }
}
