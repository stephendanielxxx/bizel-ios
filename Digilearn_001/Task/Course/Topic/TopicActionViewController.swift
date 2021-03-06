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
    
    var isLibrary = false
    var courseId = ""
    var moduleId = ""
    var assign_id = ""
    var nextModuleName = ""
    
    var topicActionModel: TopicActionModel!
    
    var topicActionDelegate: TopicActionDelegate!
    
    var sectionCount: Int = 0
    
    @IBOutlet weak var topicView: ExpandableTableView!
    
    let URL = "\(DigilearnParams.ApiUrl)/course/get_detail_module"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topicView.expandableDelegate = self
        topicView.expansionStyle = .single
        
        let nib = UINib(nibName: "TopicActionTableViewCell", bundle: nil)
        topicView.register(nib, forCellReuseIdentifier: "topicActionIdentifier")
        
        let nibChild = UINib(nibName: "TopicItemTableViewCell", bundle: nil)
        topicView.register(nibChild, forCellReuseIdentifier: "topicItemIdentifier")
//        refreshData(isRefresh: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        topicView.expandableDelegate = self
        
        let nib = UINib(nibName: "TopicActionTableViewCell", bundle: nil)
        topicView.register(nib, forCellReuseIdentifier: "topicActionIdentifier")
        
        let nibChild = UINib(nibName: "TopicItemTableViewCell", bundle: nil)
        topicView.register(nibChild, forCellReuseIdentifier: "topicItemIdentifier")
        
        refreshData(isRefresh: true)
    }
    
    func loadData(){
        showSpinner(onView: view)
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
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
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
    private func refreshData(isRefresh: Bool) {
        if isRefresh {
            self.topicView.closeAll()
        }
        loadData()
    }
    
    @IBAction func refreshAction(_ sender: UIButton) {
        refreshData(isRefresh: true)
    }
    
}

extension TopicActionViewController: ExpandableDelegate, ActionViewDelegate{
    
    func numberOfSections(in expandableTableView: ExpandableTableView) -> Int {
        return 1
    }
    func expandableTableView(_ expandableTableView: ExpandableTableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCount
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, heightsForExpandedRowAt indexPath: IndexPath) -> [CGFloat]? {
        var count = [CGFloat]()
        let expandedCount: Int = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction?.count ?? 0
        for _ in 1...expandedCount {
            let height: CGFloat = 80
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
        
        if isLibrary {
            cell.topicName.textColor = UIColor(named: "color_2F5597")
        }else{
            if topicAction.topicFinish?.caseInsensitiveCompare("finish") == .orderedSame{
                cell.topicName.textColor = UIColor(named: "color_2F5597")
            }else{
                cell.topicName.textColor = UIColor(named: "color_7698D4")
            }
        }
        
        
        cell.topicName.text = topicAction.topicName
        return cell
    }
    
    func expandableTableView(_ expandableTableView: ExpandableTableView, expandedCellsForRowAt indexPath: IndexPath) -> [UITableViewCell]? {
        var cells = [UITableViewCell]()
        let expandedCount: Int = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction?.count ?? 0
        
        
        //        let count = self.topicActionModel?.topicDetail[indexPath.row].topicDetailAction.count ?? 0
        
        for n in 0...expandedCount-1 {
            
            let topicDetailAction: TopicDetailAction = self.topicActionModel.topicDetail[indexPath.row].topicDetailAction![n]
            
            let cell = topicView.dequeueReusableCell(withIdentifier: "topicItemIdentifier") as! TopicItemTableViewCell
            
            if isLibrary {
                cell.quizArrow.image = UIImage(named: "ic_quiz_arrow")
            }else{
                if topicDetailAction.finished?.caseInsensitiveCompare("finish") == .orderedSame {
                    cell.quizArrow.image = UIImage(named: "ic_quiz_done")
                }else{
                    cell.quizArrow.image = UIImage(named: "ic_quiz_arrow")
                }
            }
            
            cell.quizTitle.text = topicDetailAction.actionName
            
            cell.quizImage.pin_updateWithProgress = true
            cell.quizImage.contentMode = .scaleToFill
            cell.quizImage.clipsToBounds = true
            
            if topicDetailAction.actionTipe?.caseInsensitiveCompare("Quiz") == .orderedSame{
                if topicDetailAction.actionQuizImage != nil {
                    let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(topicDetailAction.actionQuizImage!)")
                    cell.quizImage.pin_setImage(from: url)
                }else{
                    cell.quizImage.image = UIImage(named: "ic_default_quiz")
                }
            }else if topicDetailAction.actionTipe?.caseInsensitiveCompare("Material") == .orderedSame{
                if let iamgeUrl = topicDetailAction.actionMaterialImage {
                    let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/material/image/\(iamgeUrl)")
                    cell.quizImage.pin_setImage(from: url)
                }else{
                    cell.quizImage.image = UIImage(named: "ic_default_quiz")
                }
            }else{
                cell.quizImage.image = UIImage(named: "ic_default_quiz")
            }
            
            cell.cardView.indexRow = indexPath.row
            cell.cardView.indexCell = n
            
            cell.cardView.addTarget(self, action: #selector(TopicActionViewController.openDetail(_:)), for: .touchUpInside)
            
            cells.append(cell)
        }
        
        return cells
    }
    
    @objc func openDetail(_ sender: BizelCardview?) {
        let indexRow = sender?.indexRow ?? 0
        let indexCell = sender?.indexCell ?? 0
        
        let topicDetail = topicActionModel.topicDetail[indexRow]
        let topicAction = topicDetail.topicDetailAction?[indexCell]
        
        let action = ActionViewController()
        action.isLibrary = self.isLibrary
        action.actionViewDelegate = self
        action.moduleTitle = topicAction!.moduleName!
        action.nextModuleName = nextModuleName
        action.courseId = courseId
        action.assign_id = assign_id
        action.moduleId = topicAction!.moduleID!
        action.topicId = topicAction!.topicID!
        action.actionId = topicAction!.actionID!
        action.indexPage = indexCell
        action.nextTopicId = topicAction!.nextTopicID!
        action.modalPresentationStyle = .fullScreen
        
        if isLibrary {
            self.present(action, animated: true, completion: nil)
        }else{
            if topicAction?.topicAccess?.caseInsensitiveCompare("random") == .orderedSame{
                self.present(action, animated: true, completion: nil)
            }else{
                if indexRow == 0 && indexCell == 0 {
                    self.present(action, animated: true, completion: nil)
                }else{
                    if indexCell > 0{
                        let topicActionBefore = topicDetail.topicDetailAction?[indexCell-1]
                        if topicActionBefore?.finished?.caseInsensitiveCompare("finish") == .orderedSame {
                            self.present(action, animated: true, completion: nil)
                        }else{
                            let alert = UIAlertController(title: "", message: "Please go through the activity in order sequentially", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }else{
                        let topicDetailBefore = topicActionModel.topicDetail[indexRow-1]
                        let topicCount = topicDetailBefore.topicDetailAction
                        let topicActionBefore = topicDetailBefore.topicDetailAction?[topicCount!.count-1]
                        
                        if topicActionBefore?.finished?.caseInsensitiveCompare("finish") == .orderedSame {
                            self.present(action, animated: true, completion: nil)
                        }else{
                            let alert = UIAlertController(title: "", message: "Please go through the activity in order sequentially", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
        }
        
    }
    
    func expandableTableView(_ expandableTableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func onModuleFinish() {
        topicActionDelegate.onDismissScreen()
    }
}

protocol TopicActionDelegate {
    func onDismissScreen()
}
