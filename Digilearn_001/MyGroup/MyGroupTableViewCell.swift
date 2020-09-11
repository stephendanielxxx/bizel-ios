//
//  MyGroupTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 10/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageDefault: UIImageView!
    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var titleGroup: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
