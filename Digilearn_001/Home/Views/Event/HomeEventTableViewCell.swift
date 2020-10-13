//
//  HomeEventTableViewCell.swift
//  Digilearn_001
//
//  Created by Teke on 11/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import Alamofire
import PINRemoteImage

class HomeEventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let URL = "\(DigilearnParams.ApiUrl)/home/get_onsite_course"
    var eventModel: EventModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        registerNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        loadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func registerNib() {
        let nib = UINib(nibName: EventCollectionViewCell.nibName, bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: EventCollectionViewCell.reuseIdentifier)
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
                            
                            self.eventModel = try decoder.decode(EventModel.self, from:data)
                            
                            if(self.eventModel?.onsite.count ?? 0 > 0){
                                
                                self.collectionView.reloadData()
                                
                            }else{
                                
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

extension HomeEventTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventModel?.onsite.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! EventCollectionViewCell
        
        let event: OnsiteList = eventModel.onsite[indexPath.row]
    
        cell.configureCell(name: event.title)
        cell.imageEvent.pin_updateWithProgress = true
        cell.imageEvent.layer.cornerRadius = 15
        cell.imageEvent.contentMode = .scaleToFill
        cell.imageEvent.clipsToBounds = true
        
        let url = Foundation.URL(string: "https://digicourse.id/digilearn/admin-master/assets.admin_master/event/image/\(event.image)")!
        
        cell.imageEvent.pin_setImage(from: url)
        
        cell.registerEvent.tag = indexPath.row
        
//        cell.registerEvent.addTarget(self, action: #selector(HomeEventTableViewCell.openDetail(_:)), for: .touchUpInside)
        
        let tap = HomeEventGesture(target: self, action: #selector(openDetail(_:)))
        tap.event = event
        cell.registerEvent.addGestureRecognizer(tap)
        
        if indexPath.row == 0 {
            cell.newView.isHidden = false
        }else {
            cell.newView.isHidden = true
        }
        
        cell.pageNumber.text = "\(indexPath.row+1)/\(eventModel?.onsite.count ?? 0)"
        
        return cell
    }
    
    @objc func openDetail(_ sender: HomeEventGesture?) {
        let eventDetail = EventDetailViewController()
        
        eventDetail.modalPresentationStyle = .fullScreen
        
//        let event: OnsiteList = (eventModel?.onsite[sender!.tag])!
        
        eventDetail.eventId = sender!.event.id
        
        self.window?.rootViewController?.present(eventDetail, animated: true, completion: nil)
        
    }
}

extension HomeEventTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: EventCollectionViewCell = Bundle.main.loadNibNamed(EventCollectionViewCell.nibName,
                                                                           owner: self, options: nil)?.first as? EventCollectionViewCell else {
            return CGSize.zero
        }
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: size.height)
    }
}
