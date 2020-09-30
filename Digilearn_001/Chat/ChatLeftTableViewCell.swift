//
//  ChatLeftTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 29/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ChatLeftTableViewCell: UITableViewCell {
    @IBOutlet weak var senderNameField: UILabel!
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var hourField: UILabel!
    @IBOutlet weak var replyButton: ReplayChatButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
