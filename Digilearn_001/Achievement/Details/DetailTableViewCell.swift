//
//  DetailTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 25/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var isiDetail: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
