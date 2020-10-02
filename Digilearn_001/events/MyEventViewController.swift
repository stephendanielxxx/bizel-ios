//
//  MyEventViewController.swift
//  Digilearn_001
//
//  Created by Teke on 07/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Reqres
import PINRemoteImage

class MyEventViewController: UIViewController {
    let URL = "\(DigilearnParams.ApiUrl)/home/get_onsite_course"
    
    @IBOutlet weak var tableView: UITableView!
    var eventModel: EventModel?
    var eventId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Reqres.register()
        
        tableView.delegate = self
        tableView.dataSource = self
       
        let nib = UINib(nibName: "MyEventTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "myEventIdentifier")

        // Do any additional setup after loading the view.
        loadData()
        
    }

    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    
    func loadData(){
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    
                    switch response.result {
                    case .success(let data):
                       let decoder = JSONDecoder()
                       do{

                        self.eventModel = try decoder.decode(EventModel.self, from:data)

                        if(self.eventModel?.onsite.count ?? 0 > 0){
                            
                            self.tableView.reloadData()
                            
                        }else{

                        }
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

extension MyEventViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventModel?.onsite.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 150
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myEventIdentifier") as! MyEventTableViewCell
        
        let event: OnsiteList = (eventModel?.onsite[indexPath.row])!
        
        cell.titleLabel.text = event.title
        cell.eventImage.pin_updateWithProgress = true
        cell.eventImage.layer.cornerRadius = 15
        cell.eventImage.contentMode = .scaleToFill
        cell.eventImage.clipsToBounds = true
        
        cell.registerButton.layer.cornerRadius = 15
        
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/event/image/\(event.image)")!
//
        cell.eventImage.pin_setImage(from: url)
        
        cell.registerButton.tag = indexPath.row
        
        cell.registerButton.addTarget(self, action: #selector(MyEventViewController.openDetail(_:)), for: .touchUpInside)
        
        if(indexPath.row == 0){
            cell.newLabel.isHidden = false
        }else{
            cell.newLabel.isHidden = true
        }
        
        return cell
    }

    @objc func openDetail(_ sender: UIButton?) {
        let eventDetail = EventDetailViewController()

        eventDetail.modalPresentationStyle = .fullScreen
        
        let event: OnsiteList = (eventModel?.onsite[sender!.tag])!
        
        eventDetail.eventId = event.id
        
        self.present(eventDetail, animated: true, completion: nil)
    }

}
