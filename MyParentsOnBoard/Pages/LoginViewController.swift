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
        
        performSegue(withIdentifier: "login_to_navigation", sender: self)
        
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
        guard  let _ = data else {
            self.showAlert(title: "Error", message: "Invalid response data")
            return
        }
        self.getJsonFromData(response: response)
    }
    
    private func getJsonFromData(response: HTTPURLResponse) {
        // Do something here
        // Get the json data and
        saveDataModel(dataModel: ChildDataModel(id: 1, contactDetails: nil, personalDetails: UserDataModel.PersonalDetails(firstName: "a", lastName: "b", dateOfBirth: "c", age: 2, pictureUrl: ""))
        )
    }
    
    private func saveDataModel(dataModel: DataModel) {
        guard  let appDelegate = getApplicationDelegate() else {
            showAlert(title: "Error", message: "Unable to get Application Delegate")
            return
        }
        
        CoredataManager.insertDataModel(context: appDelegate.persistentContainer.viewContext, dataModel: dataModel)
    }
    
    private func getApplicationDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private func showAlert(title: String?, message: String?) {
        MyParentsOnBoard.showAlertDialog(in: self, title: title, message: message)
    }
    
}
