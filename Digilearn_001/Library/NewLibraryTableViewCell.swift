//
//  NewLibraryTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 23/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class NewLibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCourse: UIImageView!
    @IBOutlet weak var titleCourse: UILabel!
    @IBOutlet weak var authorCourse: UILabel!
    @IBOutlet weak var modulesCourse: UILabel!
    @IBOutlet weak var startCourse: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        startCourse.layer.cornerRadius = 15
        imageCourse.pin_updateWithProgress = true
        imageCourse.makeRounded()
    }
}

extension UIImageView {

    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        self.contentMode = .scaleToFill
    }
}
