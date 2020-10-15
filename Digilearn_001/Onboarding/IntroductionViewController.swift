//
//  IntroductionViewController.swift
//  Digilearn_001
//
//  Created by Teke on 16/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//  Test

import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 15
        
        let first = FirstBoardViewController()
        embed(first, inParent: self, inView: contentView)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        contentView.addGestureRecognizer(leftSwipe)
        contentView.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .left
        {
            if index == 1 {
                showFirstBoard()
            }else if index == 2 {
                showSecondBoard()
            }
            
            index = index - 1
        }
        
        if sender.direction == .right
        {
            if index == 0 {
                showSecondBoard()
            }else if index == 1 {
                showThirdBoard()
            }
            
            index = index + 1
        }
    }
    
    @IBAction func skipAction(_ sender: UIButton) {
        showLogin()
    }
    
    @IBAction func nextAction(_ sender: UIButton) {
        
        if index == 0 {
            showSecondBoard()
        }else if index == 1 {
            showThirdBoard()
        }else if index == 2 {
            showLogin()
        }
        
        index = index + 1
    }
    
    func showLogin(){
        let login = LoginViewController()
        login.modalPresentationStyle = .fullScreen
        self.present(login, animated: true, completion: nil)
    }
    
    func showFirstBoard(){
        let first = FirstBoardViewController()
        embed(first, inParent: self, inView: contentView)
        pageControl.currentPage = 0
    }
    
    func showSecondBoard(){
        let second = SecondBoardViewController()
        embed(second, inParent: self, inView: contentView)
        pageControl.currentPage = 1
    }
    
    func showThirdBoard(){
        let third = ThirdBoardViewController()
        embed(third, inParent: self, inView: contentView)
        pageControl.currentPage = 2
    }
    
}
