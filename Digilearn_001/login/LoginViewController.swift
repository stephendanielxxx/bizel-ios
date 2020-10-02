//
//  LoginViewController.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import RxSwift
import RxCocoa
import Alamofire
import Reqres

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var phoneLogin: FPNTextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var testlabel: UILabel!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var passwordIcon: UIButton!
    @IBOutlet weak var forgetPassword: UILabel!
    @IBOutlet weak var registerButton: UIView!
    
    var iconClick = true
    var phoneValid = false;
    
    let URL = "\(DigilearnParams.ApiUrl)/user/auth/login_sementara_kaya_cinta_ku_padanya"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        Reqres.register()
        // Do any additional setup after loading the view.
        phoneLogin.delegate = self
        
        loginImage.image = UIImage(named: "login_image")
        
        phoneLogin.setFlag(key: .ID)
        phoneLogin.font = .systemFont(ofSize: 14)
        password.font = .systemFont(ofSize: 14)
        
        phoneLogin.placeholder = "Input phone number"
        
        let forget = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapFunction))
        forgetPassword.isUserInteractionEnabled = true
        forgetPassword.addGestureRecognizer(forget)
        
        let register = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.registerFunction))
        registerButton.isUserInteractionEnabled = true
        registerButton.addGestureRecognizer(register)
        
    }
    
    @IBAction func passwordIconClick(_ sender: UIButton) {
        if(iconClick == true) {
            password.isSecureTextEntry = false
            passwordIcon.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            
        } else {
            password.isSecureTextEntry = true
            passwordIcon.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
        
        iconClick = !iconClick
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let pass = password.text
        var phone = phoneLogin.getFormattedPhoneNumber(format: .E164)
        
        phone = phone?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        let passCounter = pass?.count ?? 0
//        let phoneCounter = phoneLogin.text?.count ?? 1
        
        if(!phoneValid){
            let alert = UIAlertController(title: "Login Failed", message: "Invalid phone number", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(passCounter < 6){
            let alert = UIAlertController(title: "Login Failed", message: "Minimum password is 6 character", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            
            self.showSpinner(onView: self.view)
            
            let parameters: [String:Any] = [
                "id_number": "\(phone!)",
                "password" : "\(pass!)"
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
                                let loginModel = try decoder.decode(LoginModel.self, from:data)
                                if(loginModel.code == "200"){
                                    self.saveStringPreference(value: (loginModel.user?[0].id)!, key: DigilearnsKeys.USER_ID)
                                    self.saveStringPreference(value: (loginModel.user?[0].nickname)!, key: DigilearnsKeys.USER_NICK)
                                    self.saveStringPreference(value: (loginModel.user?[0].institution)!, key: DigilearnsKeys.INSTITUT_NAME)
                                    self.saveStringPreference(value: (loginModel.user?[0].position)!, key: DigilearnsKeys.USER_POSITION)
                                    self.saveStringPreference(value: (loginModel.user?[0].firstName)!, key: DigilearnsKeys.FIRST_NAME)
                                    self.saveStringPreference(value: (loginModel.user?[0].lastName)!, key: DigilearnsKeys.LAST_NAME)
                                    self.saveStringPreference(value: (loginModel.user?[0].photo)!, key: DigilearnsKeys.USER_PHOTO)
                                    self.saveStringPreference(value: (loginModel.user?[0].email)!, key: DigilearnsKeys.EMAIL)
                                    self.saveStringPreference(value: (loginModel.user?[0].phone)!, key: DigilearnsKeys.PHONE)
                                    self.saveStringPreference(value: (loginModel.user?[0].notification)!, key: DigilearnsKeys.USER_NOTIFICATION)
                                    self.saveStringPreference(value: pass!, key: DigilearnsKeys.USER_PASSWORD)
                                
                                    let home = HomeTabBarController()
                                    home.modalPresentationStyle = .fullScreen
                                    
                                    self.present(home, animated: true, completion: nil)
                                }else{
                                    let alert = UIAlertController(title: "Login Failed", message: "\(loginModel.message)", preferredStyle: .alert)
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
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        
        let forgetPassword = ForgetPasswordViewController()
        
        forgetPassword.modalPresentationStyle = .fullScreen
        
        self.present(forgetPassword, animated: true, completion: nil)
    }
    
    @objc func registerFunction(sender:UITapGestureRecognizer) {
        let register = RegisterViewController()
        
        register.modalPresentationStyle = .fullScreen
        
        self.present(register, animated: true, completion: nil)
    }
    
}

extension LoginViewController: FPNTextFieldDelegate{
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

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    func validate(emailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: emailAddress)
    }
}

extension UIViewController {
    func saveStringPreference(value: String, key: String){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    
    func readStringPreference(key: String) -> String {
        let preferences = UserDefaults.standard
        return preferences.string(forKey: key) ?? ""
    }
}

