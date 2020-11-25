//
//  BaseActionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 17/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift

class BaseActionViewController: UIViewController {
    var isLibrary = false
    var actionDelegate: ActionDelegate!
    var courseId = ""
    var moduleId = ""
    var topicId = ""
    var actionId = ""
    var assign_id = ""
    var userId: String?
    var nickName: String?
    var submitProgressModel: SubmitProgressModel!
    let submitURL = "\(DigilearnParams.ApiUrl)/score/finish_progress"
    var downloadProgress: DownloadProgressViewController!
    var downloadSuccess: DownloadSuccessViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapToHideKeyboard()
        
        userId = readStringPreference(key: DigilearnsKeys.USER_ID)
        nickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
    }
    
    func showCorrectToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = UIColor(named: "color_0CA422")!
        style.messageColor = UIColor.white
        ToastManager.shared.style = style
        self.view.hideAllToasts()
        self.view.makeToast(message)
    }
    
    func showFalseToast(message: String) {
        var style = ToastStyle()
        style.backgroundColor = UIColor.red
        style.messageColor = UIColor.white
        ToastManager.shared.style = style
        self.view.hideAllToasts()
        self.view.makeToast(message)
    }
    
    func replaceNickname(text: String) -> String {
        var result = text.replacingOccurrences(of: "{{nickname}}", with: nickName!)
        result = result.replacingOccurrences(of: "{{Nickname}}", with: nickName!)
        result = result.replacingOccurrences(of: "{{NICKNAME}}", with: nickName!)
        return result
    }
    
    func downloadImage (filename: String) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory,options: .removePreviousFile)
        let url = "https://digicourse.id/digilearn/admin-master/assets.admin_master/action/quiz/image/\(filename)"
        AF.download(url, to: destination).downloadProgress{
            progress in
            self.showDownloadProgress()
        }.response {response in
            
            if response.error != nil {
                // error
                debugPrint("Error download image")
            }
            else {
                // success
                self.dismiss(animated: true, completion: {() -> Void in
                    self.showDownloadSuccess()
                })
                debugPrint("Success download image")

            }
        
        }
    }
    
    func showDownloadProgress(){
        downloadProgress = DownloadProgressViewController()
        downloadProgress.providesPresentationContextTransitionStyle = true
        downloadProgress.definesPresentationContext = true
        downloadProgress.modalPresentationStyle = .overCurrentContext
        downloadProgress.modalTransitionStyle = .crossDissolve
        present(downloadProgress, animated: true, completion: nil)
    }
    
    func showDownloadSuccess(){
        downloadSuccess = DownloadSuccessViewController()
        downloadSuccess.providesPresentationContextTransitionStyle = true
        downloadSuccess.definesPresentationContext = true
        downloadSuccess.modalPresentationStyle = .overCurrentContext
        downloadSuccess.modalTransitionStyle = .crossDissolve
        present(downloadSuccess, animated: true, completion: nil)
    }
    
    func submitProgress(courseId: String, moduleId: String, topicId: String, actionId: String, answer: String, assign_id: String){
        
        if !isLibrary {
            let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
            let parameters: [String:Any] = [
                "uid": "\(user_id)",
                "course_id": "\(courseId)",
                "module_id": "\(moduleId)",
                "topic_id": "\(topicId)",
                "action_id" : "\(actionId)",
                "answer" : "\(answer)",
                "assign_id" : "\(assign_id)"
            ]
            
            AF.request(submitURL,
                       method: .post,
                       parameters: parameters,
                       encoding: URLEncoding.httpBody).responseData { response in
                        switch response.result {
                        case .success(let data):
                            self.removeSpinner()
                            let decoder = JSONDecoder()
                            do{
                                self.submitProgressModel = try decoder.decode(SubmitProgressModel.self, from:data)
                                self.actionDelegate.onSubmitProgress(message: (self.submitProgressModel?.message)!)
                                
                            }catch{
                                print(error.localizedDescription)
                            }
                        case .failure(_):
                            self.removeSpinner()
                        }
            }
        }
    }
    
}

protocol ActionDelegate{
    func onSubmitProgress(message: String)
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
