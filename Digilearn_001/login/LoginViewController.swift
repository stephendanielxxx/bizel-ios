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
    let URL = "https://digicourse.id/api_digilearn/user/auth/login_sementara_kaya_cinta_ku_padanya"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Reqres.register()
        // Do any additional setup after loading the view.
        phoneLogin.delegate = self
        
        loginImage.image = UIImage(named: "login_image")
        
        phoneLogin.setFlag(key: .ID)
        
        password.text = "teketampan"
//        phoneLogin.text = "82117836220"
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        var pass = password.text
        var phone = phoneLogin.getFormattedPhoneNumber(format: .E164)
        
        phone = phone?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
    
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

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
                        print(error)
                    }
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
    }
 
}

extension LoginViewController: FPNTextFieldDelegate{
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
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
