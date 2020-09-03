//
//  PhoneLoginView.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import FlagPhoneNumber

class PhoneLoginView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var phone: FPNTextField!
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       commonInit()
   }
           
   required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       commonInit()
   }
   
   func commonInit() {
        Bundle.main.loadNibNamed("PhoneLoginView", owner: self, options: nil)
    
        phone.setFlag(key: .ID)
    
       addSubview(contentView)
       contentView.frame = self.bounds
       contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
   }
}
