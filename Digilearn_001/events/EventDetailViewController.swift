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
    
    var eventId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Reqres.register()
        loadData(var: eventId)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(var eventId: String){
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

                           let eventDetailModel = try decoder.decode(EventDetailModel.self, from:data)
                            
                            let eventDetail: OnsiteDetail = eventDetailModel.onsite[0]
                            
                            self.navigationBar.topItem?.title = eventDetail.title
                            
                            self.descriptionText.attributedText = eventDetail.desc.htmlToAttributedString
                            
                            self.addressLabel.text = eventDetail.place
                        
                           }catch{
                               print(error.localizedDescription)
                           }
                           break
                       case .failure(let error):
                           debugPrint("Error")
                           break
                       }
           }
    }

}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
