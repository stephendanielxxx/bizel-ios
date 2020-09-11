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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 220
        }else{
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
//            let cell: SliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SliderIdentifier") as! SliderTableViewCell
//
//            return cell
            let cell: HomeBannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeBannerIdentifier") as! HomeBannerTableViewCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuIdentifier") as! MenuTableViewCell
            return cell
        } else {
            let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EventIdentifier") as! EventTableViewCell
            return cell
        }
    }
    
    }



    

