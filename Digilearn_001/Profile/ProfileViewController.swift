//
//  ProfileViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var discardButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        discardButton.layer.cornerRadius = 15
        saveButton.layer.cornerRadius = 15

    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden( true, animated: animated )
    }

}
