//
//  TopicActionTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 15/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import ExpandableCell

class TopicActionTableViewCell: ExpandableCell {

    @IBOutlet weak var topicName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        rightMargin = 32
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
