//
//  ListActiveTaskTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ActiveTaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleTask: UILabel!
    @IBOutlet weak var createdBy: UILabel!
    @IBOutlet weak var assignBy: UILabel!
    @IBOutlet weak var modulTask: UILabel!
    @IBOutlet weak var topicTask: UILabel!
    @IBOutlet weak var activitiesTask: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var totalTask: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startButton.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
