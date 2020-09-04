//
//  ForgetPasswordViewController.swift
//  Digilearn_001
//
//  Created by Teke on 04/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var forgetPassword: UIView!
    
    let URL = "\(DigilearnParams.ApiUrl)/api/Resetpass/forgot_password"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ForgetPasswordViewController.tapFunction))
              forgetPassword.isUserInteractionEnabled = true
              forgetPassword.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelForgetPassword(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        var emailValue = email.text
                
        if(emailValue?.isEmpty ?? true){
            let alert = UIAlertController(title: nil, message: "Please input your email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else if(!(emailValue?.isValidEmail() ?? false)){
            let alert = UIAlertController(title: nil, message: "The email you entered is INCORRECT. Please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            
            let parameters: [String:Any] = [
                "user_email": "\(emailValue!)"
            ]
            
            AF.request(URL,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.httpBody).responseData { response in
                        switch response.result {
                        case .success(let data):
                           let decoder = JSONDecoder()
                           do{
                            
                                let forgetModel = try decoder.decode(ForgetPasswordModel.self, from:data)
                            
                                if(forgetModel.code == "200"){
                                    let alert = UIAlertController(title: "Forget Password", message: "\(forgetModel.message)", preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "OK", style: .default){ (action:UIAlertAction!) in
                                            self.dismiss(animated: true, completion: nil)
                                        })
                                    self.present(alert, animated: true)
                                }else{
                                    let alert = UIAlertController(title: "Forget Password Failed", message: "\(forgetModel.message)", preferredStyle: .alert)
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
        
    }

}

extension String {
    func isValidEmail() -> Bool {
        guard !self.lowercased().hasPrefix("mailto:") else {
            return false
        }
        guard let emailDetector
            = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return false
        }
        let matches
            = emailDetector.matches(in: self,
                                    options: NSRegularExpression.MatchingOptions.anchored,
                                    range: NSRange(location: 0, length: self.count))
        guard matches.count == 1 else {
            return false
        }
        return matches[0].url?.scheme == "mailto"
    }
}
