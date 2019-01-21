//
//  SplashViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 21/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var hasData: Bool = false;
     
        if let appDelegate = getApplicationDelegate() {
            let streamArray = CoredataManager.getStreamData(context: appDelegate.persistentContainer.viewContext)
            if streamArray.count > 0 {
                hasData = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            if hasData {
                self.performSegue(withIdentifier: Constants.spalshToNavigationIdentifier, sender: self)
            } else {
                self.performSegue(withIdentifier: Constants.splashToLoginIdentifier, sender: self)
            }
        })
    }
    
    private func getApplicationDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}
