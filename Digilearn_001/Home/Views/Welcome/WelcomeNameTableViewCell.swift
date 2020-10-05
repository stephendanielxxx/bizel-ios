//
//  WelcomeNameTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 02/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class WelcomeNameTableViewCell: UITableViewCell {

    @IBOutlet weak var greetingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var greeting = ""
        
        let hour = Calendar.current.component(.hour, from: Date())
        let hourInt = Int(hour)
        
        if hourInt >= 0 && hourInt < 12 {
            greeting = "Good Morning"
        }else if hourInt >= 12 && hourInt < 16 {
            greeting = "Good Afternoon"
        }else if hourInt >= 16 && hourInt < 21 {
            greeting = "Good Evening"
        }else if hourInt >= 21 && hourInt < 24 {
            greeting = "Good Night"
        }
        
        let userNickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
        greetingLabel.text = "\(greeting) \(userNickName)"
        
    }
    
}
