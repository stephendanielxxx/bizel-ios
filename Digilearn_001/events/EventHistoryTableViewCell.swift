//
//  EventHistoryTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 05/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class EventHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
