//
//  DeleteDialogViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import PopupDialog

class DeleteDialogViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.cornerRadius = 15
        yesButton.layer.cornerRadius = 15
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
//        dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func deleteAction(_ sender: UIButton) {
        debugPrint("Run delete account")
    }
}
