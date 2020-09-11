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
        
        bottomNavBar.items = [homeItem, taskItem]
        
        bottomNavBar.selectedItem = homeItem
        
        view.addSubview(bottomNavBar)
        
        let homeViewController = HomeViewController()
        let eventViewController = MyEventViewController()
        
        homeViewController.tabBarItem = homeItem
        eventViewController.tabBarItem = taskItem
        
        viewControllers = [homeViewController, eventViewController]
    }

}

extension HomeTabBarController: MDCBottomNavigationBarDelegate{
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        self.selectedViewController = viewControllers![item.tag]
    }
}
