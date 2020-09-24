//
//  ProfileViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import DropDown

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var optionMenu: UIBarButtonItem!
    var dropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discardButton.layer.cornerRadius = 15
        saveButton.layer.cornerRadius = 15
        
        dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = optionMenu // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Contact Us", "Privacy Policy", "Settings", "Logout"]
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
        }

        dropDown.width = 200
    }
    
    @IBAction func optionAction(_ sender: UIBarButtonItem) {
        dropDown.show()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }
    
}
