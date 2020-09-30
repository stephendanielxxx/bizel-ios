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
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var chatIcon: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
    func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.register(UINib(nibName: "SliderTableViewCell", bundle: nil), forCellReuseIdentifier: "SliderIdentifier")
         tableView.register(UINib(nibName: "HomeBannerTableViewCell", bundle: nil), forCellReuseIdentifier: "homeBannerIdentifier")
        tableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuIdentifier")
        tableView.register(UINib(nibName: "HomeEventTableViewCell", bundle: nil), forCellReuseIdentifier: "homeEventIdentifier")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 180
        
        var greeting = ""
        
        let hour = Calendar.current.component(.hour, from: Date())
        let hourInt = Int(hour)
        
         if hourInt >= 0 && hourInt < 12 {
               greeting = "Good Morning"
           }else if hourInt >= 12 && hourInt < 16 {
               greeting = "Good Afternoon"
           }else if hourInt >= 16 && hourInt < 21 {
               greeting = "Good Evening"
           }else if hourInt >= 21 && hourInt < 24 {
               greeting = "Good Night"
           }
        
        let userNickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
        greetingLabel.text = "\(greeting) \(userNickName)"
    }
    
    @IBAction func chatAction(_ sender: UIBarButtonItem) {
        let groupChat = GroupChatViewController()
        groupChat.modalPresentationStyle = .fullScreen
        self.present(groupChat, animated: true, completion: nil)
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
        if indexPath.row == 1 {
            return 250
        }else{
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HomeBannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeBannerIdentifier") as! HomeBannerTableViewCell
            
            return cell
        } else if indexPath.section == 1 {
            let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MenuIdentifier") as! MenuTableViewCell
            
            cell.eventIcon.addTarget(self, action: #selector(HomeViewController.openEvent(_:)), for: .touchUpInside)
            cell.announcementicon.addTarget(self, action: #selector(HomeViewController.openAnnouncement(_:)), for: .touchUpInside)
            
             cell.groupIcon.addTarget(self, action: #selector(HomeViewController.openGroup), for: .touchUpInside)
            
            cell.achivementIcon.addTarget(self, action: #selector(HomeViewController.openAchievement), for: .touchUpInside)
            
            return cell
        } else {
            let cell: HomeEventTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeEventIdentifier") as! HomeEventTableViewCell
            return cell
        }
    }
    
    @objc func openEvent(_ sender: UIButton?) {
        let event = MyEventViewController()

        event.modalPresentationStyle = .fullScreen
    
        self.present(event, animated: true, completion: nil)
    }
    @objc func openAnnouncement(_ sender: UIButton?) {
        let event = AnnounceViewController()

        event.modalPresentationStyle = .fullScreen
    
        self.present(event, animated: true, completion: nil)
    }
    
    @objc func openGroup(_ sender: UIButton?) {
        let group = MyGroupViewController()

        group.modalPresentationStyle = .fullScreen
    
        self.present(group, animated: true, completion: nil)
    }
    @objc func openAchievement(_ sender: UIButton?) {
        let group = AchievementViewController()

        group.modalPresentationStyle = .fullScreen
    
        self.present(group, animated: true, completion: nil)
    }
}





    

