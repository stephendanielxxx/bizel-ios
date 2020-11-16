//
//  ExpiredTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ExpiredTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTask: UILabel!
    @IBOutlet weak var createdBy: UILabel!
    @IBOutlet weak var assignBy: UILabel!
    @IBOutlet weak var modulExpired: UILabel!
    @IBOutlet weak var topicExpired: UILabel!
    @IBOutlet weak var activitiesExpired: UILabel!
    @IBOutlet weak var totalTask: UILabel!
    @IBOutlet weak var progressExpired: UIProgressView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
