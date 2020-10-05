//
//  EventHistoryViewController.swift
//  Digilearn_001
//
//  Created by Teke on 05/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class EventHistoryViewController: UIViewController {
    
    @IBOutlet weak var historyView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var historyModel: EventHistoryModel?
    let URL = "\(DigilearnParams.ApiUrl)/onsite/get_register_event"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyView.delegate = self
        historyView.dataSource = self
        
        let nib = UINib(nibName: "EventHistoryTableViewCell", bundle: nil)
        historyView.register(nib, forCellReuseIdentifier: "eventHistoryIdentifier")
        
        loadData()
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loadData(){
        let userId = readStringPreference(key: DigilearnsKeys.USER_ID)
        let parameters: [String:Any] = [
            "user_id": "\(userId)"
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
                            self.historyModel = try decoder.decode(EventHistoryModel.self, from:data)
                            
                            if self.historyModel?.registeredEvent.count ?? 0
                                > 0 {
                                self.emptyView.isHidden = true
                                self.historyView.isHidden = false
                            }else{
                                self.emptyView.isHidden = false
                                self.historyView.isHidden = true
                            }
                            
                            self.historyView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                            self.showToast(message: "No event history")
                            self.emptyView.isHidden = false
                            self.historyView.isHidden = true
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
    func showToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.black
        style.messageColor = UIColor.white
        ToastManager.shared.style = style
        
        self.view.makeToast(message)
    }
}

extension EventHistoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyModel?.registeredEvent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventHistoryIdentifier") as! EventHistoryTableViewCell
        let history = historyModel?.registeredEvent[indexPath.row]
        //        if history != nil {
        cell.eventName.text = history?.name
        cell.eventDate.text = "Registered at : \(history?.date ?? "")"
        
//        cell.eventImage.pin_updateWithProgress = true
        cell.eventImage.contentMode = .scaleToFill
        cell.eventImage.clipsToBounds = true
        
//        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/event/image/\(history!.img!)")
//        cell.eventImage.pin_setImage(from: url)
        //        }
        return cell
    }
}
