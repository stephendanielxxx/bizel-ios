//
//  GroupChatTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 28/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class GroupChatTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var lastChatLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
