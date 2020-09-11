//
//  SliderTableViewCell.swift
//  bizelcoba1
//
//  Created by Seraphina Tatiana   on 08/08/20.
//  Copyright © 2020 Alcestfini. All rights reserved.
//

import UIKit

class SliderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BannerIdentifier")
        
        let userNickName = readStringPreference(key: DigilearnsKeys.USER_NICK)
        nameLabel.text = "Good Afternoon \(userNickName)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension SliderTableViewCell: UICollectionViewDelegate {
    
}

extension SliderTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
}

extension SliderTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerIdentifier", for: indexPath) as! BannerCollectionViewCell
            cell.imageViewBanner.image = UIImage(named: "Banner Corporate Apps-45")
            return cell
            
        } else {
            let cell: BannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerIdentifier", for: indexPath) as! BannerCollectionViewCell
            cell.imageViewBanner.image = UIImage(named: "Banner Corporate Apps-48")
            return cell
        }
    }
}

