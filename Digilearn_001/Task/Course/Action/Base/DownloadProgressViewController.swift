//
//  DownloadProgressViewController.swift
//  Digilearn_001
//
//  Created by Teke on 25/11/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class DownloadProgressViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(closeView(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func closeView(_ tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

