//
//  ChatRightTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 29/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class ChatRightTableViewCell: UITableViewCell {

    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var hourField: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        adjustUITextViewHeight(arg: messageField)
//        self.layer.backgroundColor = UIColor.clear.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
}
