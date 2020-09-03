//
//  ViewController.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Reqres

class ViewController: UIViewController {
        
    
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Reqres.register()

        let embeddedVC = LoginViewController()
        
        embeddedVC.accessibilityFrame = loginView.bounds
        embeddedVC.willMove(toParent: self)
        loginView.addSubview(embeddedVC.view)
        embeddedVC.didMove(toParent: self)
    }
    
    @IBAction func test(_ sender: UIButton, forEvent event: UIEvent) {
         print("Helllo")
    }
}

