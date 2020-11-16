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


class FaqViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var faqView: UITableView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    
    var faqModel: FaqModel!
    var faqcatModel: FaqcatModel!
    var isSearchVisible = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faqView.delegate = self
        faqView.dataSource = self
        
        let nib = UINib(nibName: "FaqTableViewCell", bundle: nil)
        faqView.register(nib, forCellReuseIdentifier: "faqIdentifier")
        
        loadDefaultFAQ()
        loadFilterCategory()
        
        
    }
    
    @IBAction func searchButtonAction(_ sender: UIBarButtonItem) {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = UIColor(named: "red_1")
        present(searchController, animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchFaq(searchText: searchBar.text!)
    }
    
    func loadFilterCategory(){
        let URL = "\(DigilearnParams.ApiUrl)/apiari/apikategorifaqari"
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            let faqcatModel = try decoder.decode(FaqcatModel.self, from:data)
                            var x = 10
                            for faq in faqcatModel.faqCat {
                                let button = FaqCatButton(frame: CGRect(x: x, y: 10, width: 50, height: 40))
                                
                                button.categoryId = faq.faqCategory
                                
                                button.setTitle(faq.faqCatName, for: .normal)
                                button.setTitleColor(UIColor.white, for: .normal)
                                button.backgroundColor = UIColor(named: "red_1")
                                
                                button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15)
                                button.layer.cornerRadius = 15
                                
                                button.sizeToFit()
                                
                                button.addTarget(self, action: #selector(FaqViewController.filterFAQ(_:)), for: .touchUpInside)
                                
                                self.filterView.addSubview(button)
                                
                                x = Int(CGFloat(x) + button.frame.size.width + 10)
                                
                            }
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
        
    }
    
    @objc func filterFAQ(_ sender: FaqCatButton) {
        getFilteredFAQ(categoryId: sender.categoryId)
    }
    
    func getFilteredFAQ(categoryId: String){
        let URL = "\(DigilearnParams.ApiUrl)/apiari/apifilterfaq"
        let parameters: [String:Any] = [
            "faq_category": "\(categoryId)"
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
                            self.faqModel = try decoder.decode(FaqModel.self, from:data)
                            self.faqView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
    func searchFaq(searchText: String){
        let URL = "\(DigilearnParams.ApiUrl)/apiari/apisubmitfaq"
        let parameters: [String:Any] = [
            "teks": "\(searchText)"
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
                            self.faqModel = try decoder.decode(FaqModel.self, from:data)
                            self.faqView.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(_):
                        self.removeSpinner()
                    }
        }
    }
    
    func loadDefaultFAQ(){
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
                    case .failure(_):
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
        return faqModel?.faq?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = faqView.dequeueReusableCell(withIdentifier: "faqIdentifier") as! FaqTableViewCell
        let faq: FAQ = (faqModel?.faq?[indexPath.row])!
        cell.questionFaq.text = faq.faqQuestion
        cell.answerFaq.text = faq.faqAnswer
        
        return cell
    }
    
}
