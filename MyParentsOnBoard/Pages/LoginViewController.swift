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
    var appDelegate: AppDelegate!

    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate = UIApplication.shared.delegate as! AppDelegate

        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // Remove this implementation
        HttpManager.getTeacherDetails(id: "Some ID")
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
    @IBAction public func onLoginButtonPressed(sender: UIButton) {
        guard let emailId = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        login(emailId: emailId, password: password)
    }
    
    private func login(emailId: String, password: String) {
        
        let loadingDialog = showLoadingAlert(in: self, title: nil, message: "Loading")
        
        HttpManager.loginWith(emailId: emailId, password: password, callback: {
            (data, response, error) in
            loadingDialog.dismiss(animated: true, completion: nil)
            self.handleLoginResponse(data: data, response: response, error: error)
        })
    }
    
    private func handleLoginResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            self.showAlert(title: "Error", message: "\(error.localizedDescription)")
            return
        }
        guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
            self.showAlert(title: "Error", message: "Unknown Error")
            return
        }
        guard  let data = data else {
            self.showAlert(title: "Error", message: "Invalid response data")
            return
        }
        self.getJsonFromData(data: data)
    }
    
    private func getJsonFromData(data: Data) {
        var jsonData: Data
        do {
            jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        } catch let e as NSError {
            self.showAlert(title: "Error", message: "Caught error while parsing\n\(e.localizedDescription)")
            return
        }
      
        print(jsonData)
        let object = StreamModel.init(id: "data", cameraUrl: "sdfs", thumbUrl: "df", streamType: "sdfg", cameraName: "jsdfh")
        //(id: "data", cameraUrl: "sdfs", thumbUrl: "df", streamType: "sdfg", cameraName: "jsdfh")
        CoredataManager.insertStreamData(appDelegate, object) // <- this line ano?

    }
    
    private func showAlert(title: String?, message: String?) {
        MyParentsOnBoard.showAlertDialog(in: self, title: title, message: message)
    }
    
}
