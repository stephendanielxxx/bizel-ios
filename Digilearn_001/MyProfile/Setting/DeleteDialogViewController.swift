//
//  DeleteDialogViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import PopupDialog

class DeleteDialogViewController: BaseSettingViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    var delegate: DeleteDialogDelegate!
    
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
        
        delegate.onDeleteAccount()
    }
}

protocol DeleteDialogDelegate {
    func onDeleteAccount()
}
