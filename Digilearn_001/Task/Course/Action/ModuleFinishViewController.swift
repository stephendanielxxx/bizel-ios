//
//  ModuleFinishViewController.swift
//  Digilearn_001
//
//  Created by Teke on 18/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ModuleFinishViewController: UIViewController {

    var currentModule = ""
    var nextModule = ""
    var moduleFinishDelegate: ModuleFinishDelegate!
    
    @IBOutlet weak var moduleTitle: UILabel!
    @IBOutlet weak var nextModuleTitle: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moduleTitle.text = currentModule
        nextModuleTitle.text = nextModule
        
        backButton.layer.cornerRadius = 15
    }

    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            self.moduleFinishDelegate.onBackToModule()
        })
    }
}

protocol ModuleFinishDelegate{
    func onBackToModule()
}
