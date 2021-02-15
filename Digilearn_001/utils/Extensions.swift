//
//  Extensions.swift
//  Digilearn_001
//
//  Created by Teke on 06/10/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {

    @objc var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"Medium") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }

    @objc var substituteFontNameRegular : String {
           get { return self.font.fontName }
           set {
               debugPrint(self.font.fontName)
               if self.font.fontName.range(of:"Regular") != nil {
                   self.font = UIFont(name: newValue, size: self.font.pointSize)
               }
           }
       }
    
    @objc var substituteFontNameBold : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"Bold") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    @objc var substituteFontNameSemiBold : String {
        get { return self.font.fontName }
        set {
            debugPrint(self.font.fontName)
            if self.font.fontName.range(of:"Semibold") != nil {
                debugPrint("SEMI BOLD \(self.font.fontName)")
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
    
    @objc var substituteFontNameHeavy : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"Heavy") != nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}
extension UITextField {
    var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
}
extension UIFont {
    class func appRegularFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Regular", size: size)!
    }
    class func appBoldFontWith( size:CGFloat ) -> UIFont{
        return  UIFont(name: "Montserrat-Bold", size: size)!
    }
}
