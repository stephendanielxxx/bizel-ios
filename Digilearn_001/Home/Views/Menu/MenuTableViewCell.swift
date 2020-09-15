//
//  MenuTableViewCell.swift
//  bizelcoba1
//
//  Created by Seraphina Tatiana   on 08/08/20.
//  Copyright © 2020 Alcestfini. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var groupIcon: UIButton!
    @IBOutlet weak var announcementicon: UIButton!
    @IBOutlet weak var eventIcon: UIButton!
    @IBOutlet weak var achivementIcon: UIButton!
    @IBOutlet weak var faqIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
