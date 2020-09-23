//
//  LibraryViewController.swift
//  Digilearn_001
//
//  Created by Teke on 23/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var newLibrary: UITableView!
    @IBOutlet weak var allLibrary: UITableView!
    
    let newURL = "\(DigilearnParams.ApiUrl)/api/apicoursenow"
    let allURL = "\(DigilearnParams.ApiUrl)/api/apicourse"
    
    var newLibraryModel: GetLibraryModel!
    var allLibraryModel: GetLibraryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "NewLibraryTableViewCell", bundle: nil)
        newLibrary.register(nib, forCellReuseIdentifier: "newLibraryIdentifier")
        
        newLibrary.delegate = self
        newLibrary.dataSource = self
        
        let nibAll = UINib(nibName: "NewLibraryTableViewCell", bundle: nil)
        allLibrary.register(nibAll, forCellReuseIdentifier: "newLibraryIdentifier")
        
        allLibrary.delegate = self
        allLibrary.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        loadNewData()
        loadAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
    func loadNewData(){
        
        AF.request(newURL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.newLibraryModel = try decoder.decode(GetLibraryModel.self, from:data)
                            self.newLibrary.reloadData()
                            
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
    }
    
    func loadAllData(){
           
           AF.request(allURL,
                      method: .get,
                      parameters: nil,
                      encoding: JSONEncoding.default).responseData { response in
                       switch response.result {
                       case .success(let data):
                           self.removeSpinner()
                           let decoder = JSONDecoder()
                           do{
                               self.allLibraryModel = try decoder.decode(GetLibraryModel.self, from:data)
                               self.allLibrary.reloadData()
                               
                           }catch{
                               print(error.localizedDescription)
                           }
                       case .failure(let error):
                           self.removeSpinner()
                       }
           }
       }
    
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newLibrary{
            return newLibraryModel?.library.count ?? 0
            
        }else {
            return allLibraryModel?.library.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newLibrary {
            let cell = newLibrary.dequeueReusableCell(withIdentifier: "newLibraryIdentifier") as! NewLibraryTableViewCell
            let libraryModel = newLibraryModel?.library[indexPath.row]
            cell.titleCourse.text = libraryModel!.courseName
            cell.authorCourse.text = "Created By : \(libraryModel!.institutName)"
            
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/course/image/\(libraryModel!.courseImage)")!
            cell.imageCourse.pin_setImage(from: url)
            
            cell.modulesCourse.text = "Modules | Topics | Actions"
            
            return cell
        }else{
            let cell = allLibrary.dequeueReusableCell(withIdentifier: "newLibraryIdentifier") as! NewLibraryTableViewCell
            let libraryModel = allLibraryModel?.library[indexPath.row]
            cell.titleCourse.text = libraryModel!.courseName
            cell.authorCourse.text = "Created By : \(libraryModel!.institutName)"
            let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/course/image/\(libraryModel!.courseImage)")!
            cell.imageCourse.pin_setImage(from: url)
            return cell
        }
    }
}

