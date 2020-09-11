//
//  ViewController.swift
//  bizelcoba1
//
//  Created by Seraphina Tatiana   on 07/08/20.
//  Copyright © 2020 Alcestfini. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderIdentifier")
         tableView.register(UINib(nibName: "HomeBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "homeBannerIdentifier")
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuIdentifier")
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventIdentifier")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        debugPrint(indexPath.row)
//        if(indexPath.row == 0){
//            return 250
//        }else if(indexPath.row == 1){
//            return 10
//        }else{
//            return 100
//        }
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
//            let cell: SliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SliderIdentifier") as! SliderTableViewCell
//
//            return cell
            let cell: HomeBannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeBannerIdentifier") as! HomeBannerTableViewCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuIdentifier") as! MenuTableViewCell
            
            cell.eventIcon.addTarget(self, action: #selector(HomeViewController.openEvent(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventIdentifier") as! EventTableViewCell
            return cell
        }
    }
    
    @objc func openEvent(_ sender: UIButton?) {
        let event = MyEventViewController()

        event.modalPresentationStyle = .fullScreen
    
        self.present(event, animated: true, completion: nil)
    }
    
}





    

