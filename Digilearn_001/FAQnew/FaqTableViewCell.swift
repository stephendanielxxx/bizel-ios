//
//  FaqTableViewCell.swift
//  Digilearn_001
//
//  Created by Seraphina Tatiana   on 22/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class FaqTableViewCell: UITableViewCell {
    @IBOutlet weak var questionFaq: UILabel!
    @IBOutlet weak var answerFaq: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
