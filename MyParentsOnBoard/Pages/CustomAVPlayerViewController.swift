//
//  CustomAVPlayerViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 29/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import AVKit

public class CustomAvPlayerViewController: AVPlayerViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
//        let directions: [UISwipeGestureRecognizer.Direction] = [.left, .right]
//        for direction in directions {
//            let gesture = UISwipeGestureRecognizer(target: self.view, action: Selector(("handleSwipe:sender:")))
//
//            gesture.direction = direction
//            self.view.addGestureRecognizer(gesture)
//        }
        
        addGestureObserverView()
    }
    
    public func addGestureObserverView() {
        
        let view = UIView()
        view.accessibilityIdentifier = "Gesture absorber"
        view.frame = self.view.bounds
        
        let gesture = UIGestureRecognizer(target: view, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(gesture)
        
        
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        print("Tapped")
    }
    
    public func handleSwipe(sender: UIGestureRecognizer) {
        print(sender)
        guard let sender = sender as? UISwipeGestureRecognizer else {
            return
        }
        print("Swiped: \(sender.direction)")
    }
}
