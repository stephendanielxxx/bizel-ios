//
//  ChatViewController.swift
//  Digilearn_001
//
//  Created by Teke on 29/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import FirebaseDatabase
import CodableFirebase

class ChatViewController: UIViewController {
    
    var groupName = ""
    var groupId = ""
    var ref: DatabaseReference!
    var chatList: [ChatModel] = []
    
    @IBOutlet weak var messageField: UITextView!
    @IBOutlet weak var messageView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sendMessageButton: UIImageView!
    
    @IBOutlet weak var navbar: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference().child(groupId)
        
        navbar.title = groupName
        
        messageField.layer.cornerRadius = 15
        messageField.layer.borderWidth = 1
        messageField.layer.borderColor = UIColor.lightGray.cgColor
        
        
        let nib = UINib(nibName: "ChatRightTableViewCell", bundle: nil)
        messageView.register(nib, forCellReuseIdentifier: "chatRightIdentifier")
        
        let nibLeft = UINib(nibName: "ChatLeftTableViewCell", bundle: nil)
        messageView.register(nibLeft, forCellReuseIdentifier: "chatLeftIdentifier")
        
        messageView.delegate = self
        messageView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.sendMessage(gesture:)))
        sendMessageButton.addGestureRecognizer(tapGesture)
        sendMessageButton.isUserInteractionEnabled = true
        
        self.ref.observe(.childAdded, with: { (snapshot) in
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(ChatModel.self, from: value)
                self.chatList.append(model)

            } catch let error {
                debugPrint(error)
            }
            
            self.messageView.reloadData()
            let indexPath = NSIndexPath(item: self.chatList.count - 1, section: 0)
            self.messageView.scrollToRow(at: indexPath as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            
        })
    }
    
    @objc func sendMessage(gesture: UIGestureRecognizer) {
        if messageField.text.count > 0 {
            let email = readStringPreference(key: DigilearnsKeys.EMAIL)
            let message = messageField.text!
            let namaYangDibales = ""
            let name = readStringPreference(key: DigilearnsKeys.USER_NICK)
            let pesanYangDibales = ""
            let read = "nope"
            let waktuDetik = ""
            let waktuHari = "29/09/2020"
            let waktuJamMenit = "15:25"
            saveToFirebase(email: email, message: message, namayangdibales: namaYangDibales, name: name, pesanyangdibales: pesanYangDibales, read: read, waktudetik: waktuDetik,
                           waktuhari: waktuHari, waktujammenit: waktuJamMenit)
            messageField.text = ""
        }
    }
    
    func saveToFirebase(email: String, message: String, namayangdibales: String, name: String, pesanyangdibales: String, read: String,
                        waktudetik: String, waktuhari: String, waktujammenit: String) {
        let dict = ["email":email, "message": message, "namayangdibales":namayangdibales, "name":name, "pesanyangdibales":pesanyangdibales,
                    "read":read, "waktudetik":waktudetik, "waktuhari":waktuhari, "waktujammenit":waktujammenit]

       let thisUserRef = ref.childByAutoId()
       thisUserRef.setValue(dict)
    }
    
    @IBAction func backAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat:ChatModel = chatList[indexPath.row]
        let emailuser = readStringPreference(key: DigilearnsKeys.EMAIL)
        if chat.email.caseInsensitiveCompare(emailuser) == .orderedSame {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatRightIdentifier") as! ChatRightTableViewCell
            cell.layer.backgroundColor = UIColor.clear.cgColor
            
            cell.dateField.text = chat.waktuhari
            cell.hourField.text = chat.waktujammenit
            cell.messageField.text = chat.message
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "chatLeftIdentifier") as! ChatLeftTableViewCell
            cell.layer.backgroundColor = UIColor.clear.cgColor
            
            cell.dateField.text = chat.waktuhari
            cell.hourField.text = chat.waktujammenit
            cell.messageField.text = chat.message
            cell.senderNameField.text = chat.name
            return cell
        }
    }
}
