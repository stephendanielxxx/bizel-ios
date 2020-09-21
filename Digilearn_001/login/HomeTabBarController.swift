//
//  HomeTabBarController.swift
//  Digilearn_001
//
//  Created by Teke on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialBottomNavigation

class HomeTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let bottomNavBar = MDCBottomNavigationBar()
        
        bottomNavBar.delegate = self
        bottomNavBar.titleVisibility = MDCBottomNavigationBarTitleVisibility.selected
        bottomNavBar.alignment = MDCBottomNavigationBarAlignment.justifiedAdjacentTitles
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        let taskItem = UITabBarItem(title: "Task", image: UIImage(named: "ic_task"), tag: 1)
        let libraryItem = UITabBarItem(title: "Library", image: UIImage(named: "ic_library"), tag: 2)
        let profileItem = UITabBarItem(title: "Profile", image: UIImage(named: "ic_profile"), tag: 3)
        
        bottomNavBar.items = [homeItem, taskItem, libraryItem, profileItem]
        
        bottomNavBar.selectedItem = homeItem
        
        view.addSubview(bottomNavBar)
        
        let homeViewController = HomeViewController()
        let taskViewController = MyTaskViewController()
        let test1 = MyEventViewController()
        let test2 = MyEventViewController()
        
        homeViewController.tabBarItem = homeItem
        taskViewController.tabBarItem = taskItem
        test1.tabBarItem = libraryItem
        test2.tabBarItem = profileItem
        
        viewControllers = [homeViewController, taskViewController, test1, test2]
        
//        self.navigationController?.isNavigationBarHidden = true;
//        self.tabBarController?.tabBar.isHidden = true
//
//        self.navigationItem.title = "Test"
        self.navigationController?.navigationBar.backgroundColor = UIColor.red
//
        self.tabBarController?.navigationController?.navigationBar.backgroundColor = UIColor(named: "red_1")
//        self.tabBarController?.navigationController?.navigationBar.tintColor = UIColor.white
//        self.tabBarController?.navigationController?.navigationItem.title = "Test"
//
//        self.tabBarController?.tabBar.isHidden = true
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.red

    }

}

extension HomeTabBarController: MDCBottomNavigationBarDelegate{
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        self.selectedViewController = viewControllers![item.tag]
    }
}
