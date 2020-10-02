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
                                
                                self.pageControl.numberOfPages = self.bannerModel!.banner.count
                                
                                var jsonArray = [InputSource]()
                                var index = 0
                                for _ in self.bannerModel.banner{
                                    let urlImage: String = self.bannerModel.banner[index].image
                                    let image = AlamofireSource(urlString: "https://digicourse.id/digilearn/admin-master/assets.admin_master/banner/image/\(urlImage)")
                                    jsonArray.append(image!)
                                    index+=1
                                }
                                
                                self.slideShow.setImageInputs(jsonArray)
                                
                            }
                        }catch{
                            print(error.localizedDescription)
                        }
                        break
                    case .failure(_):
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
