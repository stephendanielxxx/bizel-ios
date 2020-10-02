

import UIKit
import Alamofire

class TopicsViewController: UIViewController {
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var listTopics: UITableView!
    
    var module_id = ""
    var uid = ""
    var topic_name = ""
    
    var topicModel: TopicModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTopics.delegate = self
        listTopics.dataSource = self
        
        let nib = UINib(nibName: "TopicsTableViewCell", bundle: nil)
        listTopics.register(nib, forCellReuseIdentifier: "topicIdentifier")
        
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        debugPrint("MODULE \(module_id)")
        debugPrint(user_id)
        let URL = "\(DigilearnParams.ApiUrl)/score/get_all_achievement"
        let parameters: [String:Any] = [
            "uid": "\(user_id)",
            "module_id": "\(module_id)"
        ]
        AF.request(URL,
                   method: .post,
                   parameters: parameters,
                   encoding: URLEncoding.httpBody).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            self.topicModel = try decoder.decode(TopicModel.self, from:data)
                            self.listTopics.reloadData()
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
        }
        
    }
}


extension TopicsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicModel?.achievement.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTopics.dequeueReusableCell(withIdentifier: "topicIdentifier") as! TopicsTableViewCell
        let topic: Achievement = (topicModel?.achievement[indexPath.row])!
        cell.topicName.text = topic.topicName
        cell.topicDownload.tag = Int(topic.topicID)!
        cell.topicDownload.addTarget(self,action: #selector(TopicsViewController.download(_:)),for: .touchUpInside)
        
        return cell
    }
    @objc func download(_ sender: UIButton?) {
        generatepdf(topic_id: String(sender!.tag))
    }
    
    
    func generatepdf (topic_id: String) {
        let user_id = readStringPreference(key: DigilearnsKeys.USER_ID)
        let URL = "\(DigilearnParams.ApiUrl)/api/apireport/pdf?user_id=\(user_id)&topic_id=\(topic_id)"
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    switch response.result {
                    case .success(let data):
                        self.removeSpinner()
                        let decoder = JSONDecoder()
                        do{
                            let download = try decoder.decode(DownloadModel.self, from:data)
                            self.downloadpdf(filename: download.message)
                        }catch{
                            print(error.localizedDescription)
                        }
                    case .failure(let error):
                        self.removeSpinner()
                    }
                    
        }
        
    }
    func downloadpdf (filename: String) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        let url = "https://digicourse.id/digilearn/member/assets.digilearn/pdf/\(filename)"
        AF.download(url, to: destination).response {response in debugPrint(response)}
    }
    
}
