//
//  HomeBannerTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage

class HomeBannerTableViewCell: UITableViewCell {

    @IBOutlet weak var slideShow: ImageSlideshow!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    
    let URL = "\(DigilearnParams.ApiUrl)/home/get_home_banner"
    var bannerModel: BannerModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slideShow.pageIndicator = pageControl
        
        slideShow.contentScaleMode = .scaleToFill
        slideShow.clipsToBounds = true
        
        slideShow.scrollView.layer.cornerRadius = 15
        
        slideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .under)

        loadData()
        
        var greeting = ""
        
        let hour = Calendar.current.component(.hour, from: Date())
        let hourInt = Int(hour)
        
         if hourInt >= 0 && hourInt < 12 {
               greeting = "Good Morning"
           }else if hourInt >= 12 && hourInt < 16 {
               greeting = "Good Afternoon"
           }else if hourInt >= 16 && hourInt < 21 {
               greeting = "Good Evening"
           }else if hourInt >= 21 && hourInt < 24 {
               greeting = "Good Night"
           }
        
        let userNickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
        nameLabel.text = "\(greeting) \(userNickName)"
    
    }
    
    func loadData(){
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default).responseData { response in
                    
                    switch response.result {
                    case .success(let data):
                       let decoder = JSONDecoder()
                       do{

                        self.bannerModel = try decoder.decode(BannerModel.self, from:data)

                        if(self.bannerModel?.banner.count ?? 0 > 0){
                            
                            self.pageControl.numberOfPages = self.bannerModel?.banner.count as! Int
                            
                            var jsonArray = [InputSource]()
                            var index = 0
                            for banner in self.bannerModel.banner{
                                let urlImage: String = self.bannerModel.banner[index].image
                                var image = AlamofireSource(urlString: "https://digicourse.id/digilearn/admin-master/assets.admin_master/banner/image/\(urlImage)")
                                jsonArray.append(image as! InputSource)
                                index+=1
                            }
                            
                            self.slideShow.setImageInputs(jsonArray)
                            
                        }else{

                        }
                       }catch{
                            print(error.localizedDescription)
                        }
                        break
                    case .failure(let error):
                        debugPrint("Error")
                        break
                    }
        }
    }
    

}

extension UITableViewCell {
    func saveStringPreference(value: String, key: String){
        let preferences = UserDefaults.standard
        preferences.set(value, forKey: key)
        preferences.synchronize()
    }
    
    func readStringPreference(key: String) -> String {
        let preferences = UserDefaults.standard
        return preferences.string(forKey: key) ?? ""
    }
}
