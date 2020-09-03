//
//  BottomLoginView.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class BottomLoginView: UIView {
    
    
    @IBOutlet var bottomView: UIView!
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("BottomLoginView", owner: self, options: nil)
        addSubview(bottomView)
        bottomView.frame = self.bounds
        bottomView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
