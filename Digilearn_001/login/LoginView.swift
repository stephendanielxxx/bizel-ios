//
//  LoginView.swift
//  Digilearn_001
//
//  Created by Teke on 02/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

@IBDesignable
class LoginView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var loginImage: UIImageView!
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      commonInit()
    }
          
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
          commonInit()
      }
  
      func commonInit() {
          Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
          addSubview(contentView)
          contentView.frame = self.bounds
          contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      }
}
