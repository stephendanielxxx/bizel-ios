//
//  DownloadSuccessViewController.swift
//  Digilearn_001
//
//  Created by Teke on 25/11/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class DownloadSuccessViewController: UIViewController {
    @IBOutlet weak var downloadLabel: UILabel!
    var destination : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        view.addGestureRecognizer(gesture)
        downloadLabel.text = "Imaged saved as \(destination!)"
    }
    
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
