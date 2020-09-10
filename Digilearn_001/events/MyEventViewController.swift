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

class MyEventViewController: UIViewController {
    let URL = "\(DigilearnParams.ApiUrl)/home/get_onsite_course"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Reqres.register()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "eventTableViewCell")


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

                            let eventModel = try decoder.decode(EventModel.self, from:data)

                            if(eventModel.onsite.count ?? 0 > 0){
                                debugPrint(eventModel)
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
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventTableViewCell") as! EventTableViewCell
        return cell
    }


}
