//
//  MaterialVideoViewController.swift
//  Digilearn_001
//
//  Created by Teke on 21/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit
import BMPlayer

class MaterialVideoViewController: UIViewController {
    
    @IBOutlet weak var playerView: UIView!
    var player: BMPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var videoURL = URL.init(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")
        
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = AVPlayer(url: videoURL!)
//        playerViewController.view.frame = playerView.bounds
//
//        playerView.addSubview(playerViewController.view)
//        playerViewController.player?.play()
        
        //        let player = AVPlayer(url: videoURL!)
        //        let playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = playerView.bounds
        //        playerView.layer.addSublayer(playerLayer)
        //        player.play()
        
//        self.player = Player()
////        self.player.playerDelegate = self
////        self.player.playbackDelegate = self
//        self.player.view.frame = playerView.bounds
//
////        self.addChild(self.player)
//        playerView.addSubview(self.player.view)
////        self.player.didMove(toParent: self)
//
//        self.player.url = videoURL
//
//        self.player.playFromBeginning()
        player = BMPlayer()
        player.frame = playerView.bounds
        playerView.addSubview(player)
        player.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.right.equalTo(self.view)
            // Note here, the aspect ratio 16:9 priority is lower than 1000 on the line, because the 4S iPhone aspect ratio is not 16:9
            make.height.equalTo(player.snp.width).multipliedBy(9.0/16.0).priority(750)
        }
        
        let asset = BMPlayerResource(url: URL(string: "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4")!,
        name: "Test")
        
        player.setVideo(resource: asset)
        
        
        // Back button event
        player.backBlock = { [unowned self] (isFullScreen) in
            if isFullScreen == true { return }
            let _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
