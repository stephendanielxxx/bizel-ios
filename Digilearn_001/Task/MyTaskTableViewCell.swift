//
//  MyTaskTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 14/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class MyTaskTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var assignedLabel: UILabel!
    @IBOutlet weak var modulesLabel: UILabel!
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var activitiesLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startTaskButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var expiredLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startTaskButton.layer.cornerRadius = 15
    }

    
}
