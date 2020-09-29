//
//  AchieveModuleTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 29/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MDCCard

class AchieveModuleTableViewCell: UITableViewCell {
    @IBOutlet weak var isiModule: MDCCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
