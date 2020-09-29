//
//  FaqViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 22/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Reqres
import PINRemoteImage


class FaqViewController: UIViewController {

    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var faqView: UITableView!
    
    var faqModel: FaqModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqView.delegate = self
        faqView.dataSource = self
        
        let nib = UINib(nibName: "FaqTableViewCell", bundle: nil)
        faqView.register(nib, forCellReuseIdentifier: "faqIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/apiari/apifaqari"
       
        AF.request(URL,
        method: .get,
        parameters: nil,
        encoding: JSONEncoding.default).responseData { response in
         switch response.result {
         case .success(let data):
             self.removeSpinner()
             let decoder = JSONDecoder()
             do{
                 self.faqModel = try decoder.decode(FaqModel.self, from:data)
                 self.faqView.reloadData()
             }catch{
                 print(error.localizedDescription)
             }
         case .failure(let error):
             self.removeSpinner()
         }
}
}
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
}
extension FaqViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqModel?.faq.count ?? 0
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = faqView.dequeueReusableCell(withIdentifier: "faqIdentifier") as! FaqTableViewCell
        let faq: FAQ = (faqModel?.faq[indexPath.row])!
        cell.questionFaq.text = faq.faqQuestion
        cell.answerFaq.text = faq.faqAnswer
            
        return cell
    }

}
