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
    
    var sectionCount: Int = 0
    
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
                            
                            self.sectionCount = self.topicActionModel.topicDetail.count
                            
                            self.topicView.reloadData()
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
        return 1
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return self.topicActionModel?.topicDetail[section].topicDetailAction?.count ?? 0
        return sectionCount
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        var count = [CGFloat]()
        let expandedCount: Int = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction?.count ?? 0
        for _ in 1...expandedCount {
            let height: CGFloat = 75
            count.append(height)
        }
        return count
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, titleForFooterInSection section: Int) -> String? {
        return "Section:\(section)"
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = expandableTableView.dequeueReusableCell(withIdentifier: "topicActionIdentifier") as! TopicActionTableViewCell
        
        let topicAction: TopicDetail = self.topicActionModel.topicDetail[indexPath.row]
        
        cell.topicName.text = topicAction.topicName
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cells = [UITableViewCell]()
        let expandedCount: Int = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction?.count ?? 0
        
        //        let count = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction.count ?? 0
        
        for n in 0...expandedCount-1{
            
            let topicDetailAction: TopicDetailAction = self.topicActionModel.topicDetail[indexPath.row].topicDetailAction![n]
            
            let cell = topicView.dequeueReusableCell(withIdentifier: "topicItemIdentifier") as! TopicItemTableViewCell
            
            if topicDetailAction.finished?.caseInsensitiveCompare("finish") == .orderedSame {
                cell.quizArrow.image = UIImage(named: "ic_quiz_done")
            }else{
                cell.quizArrow.image = UIImage(named: "ic_quiz_arrow")
            }
            
            cell.quizTitle.text = topicDetailAction.actionName
            
            cell.quizImage.pin_updateWithProgress = true
            cell.quizImage.contentMode = .scaleToFill
            cell.quizImage.clipsToBounds = true
            
            if topicDetailAction.actionTipe?.caseInsensitiveCompare("Quiz") == .orderedSame{
                
                let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(topicDetailAction.actionQuizImage!)")
                cell.quizImage.pin_setImage(from: url)
                
            }else if topicDetailAction.actionTipe?.caseInsensitiveCompare("Material") == .orderedSame{
                if let iamgeUrl = topicDetailAction.actionMaterialImage {
                    let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/material/image/\(iamgeUrl)")
                    cell.quizImage.pin_setImage(from: url)
                }
            }else{
                cell.quizImage.image = UIImage(named: "ic_default_quiz")
            }
            
            cells.append(cell)
        }
        
        return cells
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
