//
//  ActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 16/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
