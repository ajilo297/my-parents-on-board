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
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let sender = sender as? UIButton, segue.identifier == Constants.homeToVideoIdentifier {
                startHomeToVideoSegue(sender: sender, segue: segue)
                return
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
    
    private func showLogoutDialog() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive, handler: {_ in
            self.logout()
        })
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: {_ in
            alert.dismiss(animated: true, completion: nil)
        })
        
        
        alert.addAction(dismissAction)
        alert.addAction(logoutAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func logout() {
        guard  let appDelegate = getApplicationDelegate() else {
            print("Unable to get Application delegate")
            return
        }
        
        let result = CoredataManager.deleteOnLogout(context: appDelegate.persistentContainer.viewContext)
        print("LOGOUT DATA DELETE RESULT: \(result)")
        
        if let controller = self.navigationController {
            controller.popViewController(animated: true)
            navigateToLoginPage()
        }
    }
    
    private func navigateToLoginPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.logiViewControllerIdentifier) as? LoginViewController else {
            return
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    private func getApplicationDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - Actions
    @IBAction public func onLiveVideoButtonClick(sender: UIButton) {
        performSegue(withIdentifier: Constants.homeToVideoIdentifier, sender: sender)
    }
    
    @IBAction public func onSpecialEventButtonClick(sender: UIButton) {
        performSegue(withIdentifier: Constants.homeToVideoIdentifier, sender: sender)
    }
    
    @IBAction public func onLogoutButtonClicked(sender: UIButton) {
        showLogoutDialog()
    }
}
