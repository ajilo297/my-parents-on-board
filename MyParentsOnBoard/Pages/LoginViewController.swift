//
//  ViewController.swift
//  MyParentsOnBoard
//
//  Created by ATS on 15/01/19.
//  Copyright © 2019 Ajil. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
            return true
        }
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Actions
    @IBAction func onLoginButtonPressed(sender: UIButton) {
        guard let emailId = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        let loadingDialog = showLoadingAlert(in: self, title: nil, message: "Loading")
        
        HttpManager.loginWith(emailId: emailId, password: password, callback: {data, response, error in
            loadingDialog.dismiss(animated: true, completion: nil)
            MyParentsOnBoard.show(key: "DATA: ", value: data)
            MyParentsOnBoard.show(key: "RESPONSE: ", value: response)
            MyParentsOnBoard.show(key: "ERROR: ", value: error)
            
            guard let data = data else {
                if let error = error {
                    showAlertDialog(in: self, title: "Error", message: "\(error.localizedDescription)")
                    return
                } else {
                    showAlertDialog(in: self, title: "Error", message: "Did not receive data")
                    return
                }
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                if let error = error {
                    showAlertDialog(in: self, title: "Error", message: "\(error.localizedDescription)")
                } else {
                    showAlertDialog(in: self, title: "Error", message: "Unknown error")
                }
                return
            }
            
            do {
                let json = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                
                print(json)
            } catch let e as NSError {
                showAlertDialog(in: self, title: "Error", message: "Invalid response\n\(e.localizedDescription)")
            }
            
        })
    }
}

