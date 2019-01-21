//
//  HomeViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var liveVideoButton: UIButton!
    @IBOutlet weak var specialEventsButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.homeToVideoIdentifier {
            if let sender = sender as? UIButton {
                startHomeToVideoSegue(sender: sender, segue: segue)
                return
            }
        }
    }
    
    private func startHomeToVideoSegue(sender: UIButton, segue: UIStoryboardSegue) {
        guard let destinationVC = segue.destination as? VideoTableViewController else {
            return
        }
        if sender == liveVideoButton {
            destinationVC.pageTitle = Constants.liveVideoPageTitle
        } else if sender == specialEventsButton {
            destinationVC.pageTitle = Constants.specialEventsPageTitle
        }
    }
    
    // MARK: - Actions
    @IBAction public func onLiveVideoButtonClick(sender: UIButton) {
        performSegue(withIdentifier: Constants.homeToVideoIdentifier, sender: sender)
    }
    
    @IBAction public func onSpecialEventButtonClick(sender: UIButton) {
        performSegue(withIdentifier: Constants.homeToVideoIdentifier, sender: sender)
    }
}
