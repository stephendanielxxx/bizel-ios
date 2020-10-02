//
//  EventDetailViewController.swift
//  Digilearn_001
//
//  Created by Teke on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Reqres
import MaterialComponents.MaterialCards

class EventDetailViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var eventId:String = ""
    var userId:String = ""
    var eventDetailModel: EventDetailModel!
    
    let URL = "\(DigilearnParams.ApiUrl)/onsite/regis_onsite"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Reqres.register()
        loadData(eventId: eventId)
        
        userId = readStringPreference(key: DigilearnsKeys.USER_ID)
        
        registerButton.layer.cornerRadius = 18
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(eventId: String){
        let URL = "\(DigilearnParams.ApiUrl)/onsite/get_detail/\(eventId)"
        
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    
                    debugPrint(response)
                    
                    switch response.result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        do{
                            
                            self.eventDetailModel = try decoder.decode(EventDetailModel.self, from:data)
                            
                            let eventDetail: OnsiteDetail =  self.eventDetailModel.onsite[0]
                            
                            self.navigationBar.topItem?.title = eventDetail.title
                            
                            self.descriptionText.attributedText = eventDetail.desc.htmlToAttributedString
                            
                            self.addressLabel.text = eventDetail.place
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                        break
                    case .failure(_):
                        debugPrint("Error")
                        break
                    }
        }
    }
    
    @IBAction func registerAction(_ sender: UIButton) {
        self.showSpinner(onView: self.view)
        
        let eventDetail: OnsiteDetail =  self.eventDetailModel.onsite[0]
        
        let parameters: [String:Any] = [
            "uid": "\(userId)",
            "event_id" : "\(eventId)",
            "event_name" : "\(eventDetail.title)"
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
                            let registerEventModel = try decoder.decode(RegisterEventModel.self, from:data)
                            
                            if(registerEventModel.code == "200"){
                                let alert = UIAlertController(title: "Event Register Success", message: "\(registerEventModel.message)", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                self.present(alert, animated: true)
                            }else{
                                let alert = UIAlertController(title: "Event Register Failed", message: "\(registerEventModel.message)", preferredStyle: .alert)
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        let htmlTemplate = """
           <!doctype html>
           <html>
             <head>
               <style>
                 body {
                   font-family: -apple-system;
                   font-size: 14px;
                 }
               </style>
             </head>
             <body>
               \(self)
             </body>
           </html>
           """
        guard let data = htmlTemplate.data(using: .utf8) else { return nil }
        do {
            let font = UIFont.systemFont(ofSize: 100)
            let attributes = [NSAttributedString.Key.font: font]
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue, .defaultAttributes: attributes], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
