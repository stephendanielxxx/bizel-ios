//
//  AnnounceTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class AnnounceTableViewCell: UITableViewCell {
    @IBOutlet weak var imageAnnounce: UIImageView!
    @IBOutlet weak var titleAnnounce: UITextView!
    @IBOutlet weak var dateAnnounce: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    
    @IBOutlet weak var detailAnnounce: MDCCard!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageAnnounce.layer.cornerRadius = imageAnnounce.frame.height/2
        imageAnnounce.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
