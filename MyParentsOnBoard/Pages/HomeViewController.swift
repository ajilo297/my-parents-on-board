//
//  HomeViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction public func onLiveVideoButtonClick(sender: UIButton) {
        performSegue(withIdentifier: "home_to_live_video", sender: self)
    }
}
