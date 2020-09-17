//
//  BaseActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class BaseActionViewController: UIViewController {
    
    var userId: String?
    var nickName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userId = readStringPreference(key: DigilearnsKeys.USER_ID)
        nickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
    }
    
    func replaceNickname(text: String) -> String {
        var result = text.replacingOccurrences(of: "{{nickname}}", with: nickName!)
        result = result.replacingOccurrences(of: "{{Nickname}}", with: nickName!)
        result = result.replacingOccurrences(of: "{{NICKNAME}}", with: nickName!)
        return result
    }
    
}

extension String {
    var htmlStringAnswerQuiz: NSAttributedString? {
        let htmlTemplate = """
           <!doctype html>
           <html>
             <head>
               <style>
                 body {
                   font-family: -apple-system;
                   font-size: 12px;
                 }
               </style>
             </head>
             <body>
               \(self)
             </body>
           </html>
           """
        guard let data = htmlTemplate.data(using: .utf8) else { return nil }
        do {
            let font = UIFont.systemFont(ofSize: 100)
            let attributes = [NSAttributedString.Key.font: font]
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue, .defaultAttributes: attributes], documentAttributes: nil)
        } catch {
            return nil
        }
    }
   
}

extension UIImageView {
  func enableZoom() {
    let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
    isUserInteractionEnabled = true
    addGestureRecognizer(pinchGesture)
  }

  @objc
  private func startZooming(_ sender: UIPinchGestureRecognizer) {
    let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
    guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
    sender.view?.transform = scale
    sender.scale = 1
  }
}
