//
//  ThreeSixtyPlayerViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 02/02/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import NYT360Video

class ThreeSixtyPlayerViewController: NYT360ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = false
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav?.topItem?.title = ""
    }
    
}
