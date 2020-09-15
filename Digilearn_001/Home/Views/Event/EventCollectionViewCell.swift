//
//  EventCollectionViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var registerEvent: UIButton!
    @IBOutlet weak var imageEvent: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        registerEvent.layer.cornerRadius = 15
        
    }
    class var reuseIdentifier: String {
        return "eventCollectionIdentifier"
    }
    class var nibName: String {
        return "EventCollectionViewCell"
    }
    
    func configureCell(name: String) {
        self.eventLabel.text = name
    }
}
