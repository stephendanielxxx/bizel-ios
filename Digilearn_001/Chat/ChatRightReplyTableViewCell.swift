//
//  ChatRightReplyTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 30/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ChatRightReplyTableViewCell: UITableViewCell {
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var hourField: UILabel!
    @IBOutlet weak var deleteChatButton: DeleteChatButton!
    @IBOutlet weak var repliedName: UILabel!
    @IBOutlet weak var repliedMessage: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
