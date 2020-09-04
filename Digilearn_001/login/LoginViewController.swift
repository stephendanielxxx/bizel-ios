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
    
    var iconClick = true
    var phoneValid = false;
    
    let URL = "\(DigilearnParams.ApiUrl)/user/auth/login_sementara_kaya_cinta_ku_padanya"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Reqres.register()
        // Do any additional setup after loading the view.
        phoneLogin.delegate = self
        
        loginImage.image = UIImage(named: "login_image")
        
        phoneLogin.setFlag(key: .ID)
        phoneLogin.font = .systemFont(ofSize: 14)
        password.font = .systemFont(ofSize: 14)
        
        phoneLogin.placeholder = "Input phone number"
                
//        let borderColor = UIColor.lightGray
//        phoneLogin.layer.borderColor = borderColor.cgColor
//        phoneLogin.layer.borderWidth = 1
//        phoneLogin.layer.cornerRadius = 5
       
//        phoneLogin.text = "82117836220"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.tapFunction))
        forgetPassword.isUserInteractionEnabled = true
        forgetPassword.addGestureRecognizer(tap)
        
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
        
        var pass = password.text
        var phone = phoneLogin.getFormattedPhoneNumber(format: .E164)
        
        phone = phone?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        var passCounter = pass?.count ?? 0
        var phoneCounter = phoneLogin.text?.count ?? 1
        
        debugPrint(phoneValid)
        
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
                                print(loginModel.message)
                            }else{
                                let alert = UIAlertController(title: "Login Failed", message: "\(loginModel.message)", preferredStyle: .alert)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {

        let forgetPassword = ForgetPasswordViewController()

        forgetPassword.modalPresentationStyle = .fullScreen
        
        self.present(forgetPassword, animated: true, completion: nil)
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
}
