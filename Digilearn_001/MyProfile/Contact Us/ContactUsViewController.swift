//
//  ContactUsViewController.swift
//  Digilearn_001
//
//  Created by Teke on 24/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import MessageUI

class ContactUsViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var buttonSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSend.layer.cornerRadius = 18

        message.layer.borderWidth = 1
        message.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendEmailAction(_ sender: UIButton) {
        if message.text.isEmpty {
            let alert = UIAlertController(title: "Contact Us", message: "Message must be filled", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else{
            sendEmail(message: message.text)
        }
    }
    
    func sendEmail(message: String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Bizel")
            mail.setToRecipients(["edcoreprogram@gmail.com"])
            mail.setMessageBody(message, isHTML: true)

            present(mail, animated: true)
        } else {
            let alert = UIAlertController(title: "Contact Us", message: "Please set up your email first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
