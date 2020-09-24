//
//  ChangePasswordViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.layer.cornerRadius = 18
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
   

}
