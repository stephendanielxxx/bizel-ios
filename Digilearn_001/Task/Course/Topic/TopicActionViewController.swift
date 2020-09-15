//
//  TopicActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import ExpandableCell

class TopicActionViewController: UIViewController {
    
    var courseId = ""
    var moduleId = ""
    
    var topicActionModel: TopicActionModel!
    
    @IBOutlet weak var topicView: ExpandableTableView!
    
    let URL = "\(DigilearnParams.ApiUrl)/course/get_detail_module"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicView.expandableDelegate = self
        topicView.expansionStyle = .single
        topicView.closeAll()
        
        let nib = UINib(nibName: "TopicActionTableViewCell", bundle: nil)
        topicView.register(nib, forCellReuseIdentifier: "topicActionIdentifier")
        
        let nibChild = UINib(nibName: "TopicItemTableViewCell", bundle: nil)
        topicView.register(nibChild, forCellReuseIdentifier: "topicItemIdentifier")
        
        loadData()
    }
    
    func loadData(){
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        debugPrint(user_id)
        debugPrint(self.courseId)
        debugPrint(self.moduleId)
        let parameters: [String:Any] = [
            "course_id": "\(self.courseId)",
            "module_id" : "\(self.moduleId)",
            "user_id" : "\(user_id)"
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
                            self.topicActionModel = try decoder.decode(TopicActionModel.self, from:data)
                            
                            debugPrint(self.topicActionModel)
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        loadData()
    }
    
}

extension TopicActionViewController: ExpandableDelegate{
    
    func numberOfSections(in expandableTableView: ExpandableTableView) -> Int {
        //        return self.topicActionModel?.topicDetail.count ?? 0
        return 2
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.topicActionModel?.topicDetail[section].topicDetailAction.count ?? 0
        return 3
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        return [50]
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "topicActionIdentifier") as! TopicActionTableViewCell
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        let cell = topicView.dequeueReusableCell(withIdentifier: "topicItemIdentifier") as! TopicItemTableViewCell
        let cell2 = topicView.dequeueReusableCell(withIdentifier: "topicItemIdentifier") as! TopicItemTableViewCell
        let cell3 = topicView.dequeueReusableCell(withIdentifier: "topicItemIdentifier") as! TopicItemTableViewCell
        return [cell, cell2, cell3]
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
