//
//  AchievementTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class AchievementTableViewCell: UITableViewCell {
    @IBOutlet weak var titleTask: UILabel!
    @IBOutlet weak var namaInstitut: UILabel!
    @IBOutlet weak var achieveDetail: MDCCard!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
