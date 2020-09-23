//
//  OnboardingViewController.swift
//  Digilearn_001
//
//  Created by Teke on 16/09/20.
//  Copyright © 2020 Digimaster. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func startAction(_ sender: UIButton) {
        let intro = IntroductionViewController()
        intro.modalPresentationStyle = .fullScreen
        self.present(intro, animated: true, completion: nil)
    }

}
