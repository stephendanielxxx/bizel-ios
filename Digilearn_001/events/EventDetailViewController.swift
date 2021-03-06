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
    @IBOutlet weak var linkLabel: UITextView!
    
    var eventId = ""
    var eventName = ""
    var userId = ""
    var eventDetailModel: EventDetailModel!
    
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
                    
                    switch response.result {
                    case .success(let data):
                        let decoder = JSONDecoder()
                        do{
                            
                            self.eventDetailModel = try decoder.decode(EventDetailModel.self, from:data)
                            
                            let eventDetail: OnsiteDetail =  self.eventDetailModel.onsite[0]
                            
                            self.navigationBar.topItem?.title = eventDetail.title
                            
                            self.descriptionText.attributedText = eventDetail.desc.htmlToAttributedString
                            
                            self.addressLabel.text = eventDetail.place
                            
                            if eventDetail.link != nil {
                                self.linkLabel.text = eventDetail.link
                            }else{
                                self.linkLabel.text = "No link provided"
                            }
                            
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
        let register = EventRegistrationViewController()
        register.eventId = eventId
        register.eventName = eventName
        register.modalPresentationStyle = .fullScreen
        present(register, animated: true, completion: nil)
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
                   font-size: 16px;
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
    var activityString: NSAttributedString? {
        let htmlTemplate = """
           <!doctype html>
           <html>
             <head>
               <style>
                 body {
                   font-family: -apple-system;
                   font-size: 20px;
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
    var activityHtmlToString: String {
        return activityString?.string ?? ""
    }
    
    var aboutString: NSAttributedString? {
        let htmlTemplate = """
           <!doctype html>
           <html>
             <head>
               <style>
                 body {
                   font-family: -apple-system;
                   font-size: 18px;
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
    var aboutHtmlToString: String {
        return aboutString?.string ?? ""
    }
    var optionString: NSAttributedString? {
        let htmlTemplate = """
           <!doctype html>
           <html>
             <head>
               <style>
                 body {
                   font-family: -apple-system;
                   font-size: 20px;
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
    var optionHtmlToString: String {
        return optionString?.string ?? ""
    }
    
}
