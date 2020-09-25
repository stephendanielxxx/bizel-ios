//
//  FaqViewController.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 22/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit


class FaqViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 15
        accountButton.layer.cornerRadius = 15
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
           }
    }


