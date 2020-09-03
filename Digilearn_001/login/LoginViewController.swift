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
        
        loginImage.image = UIImage(named: "login_image")
        
        phoneLogin.setFlag(key: .ID)
        
        password.text = "teketampan"
//        phoneLogin.text = "82117836220"
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        var pass = password.text
        var phone = phoneLogin.getFormattedPhoneNumber(format: .E164)
        debugPrint(phone)
        phone = phone?.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
    
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]

        let parameters: [String:Any] = [
            "id_number": "\(phone!)",
            "password" : "\(pass!)"
        ]

        debugPrint(parameters)
        
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseJSON { response in
                    debugPrint(response.request)
                    debugPrint(response)
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destination.
//         Pass the selected object to the new view controller.
        
    }
    

}

struct Login: Encodable {
           let id_number: String
           let password: String
       }
