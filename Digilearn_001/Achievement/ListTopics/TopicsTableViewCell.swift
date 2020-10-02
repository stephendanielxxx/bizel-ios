//
//  TopicsTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 01/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents

class TopicsTableViewCell: UITableViewCell {
    @IBOutlet weak var topicName: UILabel!
    @IBOutlet weak var topicDownload: MDCCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
