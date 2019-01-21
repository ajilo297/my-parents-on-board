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
    
    private func login(emailId: String, password: String) {
        let loadingDialog = showLoadingAlert(in: self, title: nil, message: "Loading")
        
        HttpManager.loginWith(emailId: emailId, password: password, callback: {
            (data, response, error) in
            loadingDialog.dismiss(animated: true, completion: {
                self.handleLoginResponse(data: data, response: response, error: error)
            })
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
        DispatchQueue.main.async {
            self.parseJsonFrom(data: data)
        }
    }
    
    private func parseJsonFrom(data: Data) {
        do {
            guard let dataDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                return
            }
            getDataFromDictionary(dataDictionary: dataDictionary)
        } catch let e as NSError {
            print("" + e.localizedDescription)
            return
        }
    }
    
    private func getDataFromDictionary(dataDictionary: Dictionary<String, Any>) {
        
        guard let streamObject = dataDictionary["nginxStreams"] as? Dictionary<String, Any> else {
            print("Error 101")
            return
        }
        
        guard let streamArrayList = streamObject["streams"] as? Array<Dictionary<String, String>> else {
            print("Error 102")
            return
        }
        
        guard let vodObject = dataDictionary["onDemandVideos"] as? Dictionary<String, Any> else {
            print("Error 103")
            return
        }
        
        guard let vodArrayList = vodObject["vods"] as? Array<Dictionary<String, Any>> else {
            print("Error 104")
            return
        }
        
        let streamList: Array<StreamDataModel> = getStreamDataList(dataDictionary: streamArrayList)
        
        for streamModel in streamList {
            saveDataModel(dataModel: streamModel)
        }
        
        let vodList: Array<VodDataModel> = getVodDataList(dataDictionary: vodArrayList)
        
        for vodModel in vodList {
            saveDataModel(dataModel: vodModel)
        }
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.loginToNavigationIdentifier, sender: self)
        }
    }
    
    private func getStreamDataList(dataDictionary: Array<Dictionary<String, String>>) -> Array<StreamDataModel> {
        var dataModelList: Array<StreamDataModel> = []
        
        for item in dataDictionary {
            let streamModel = StreamDataModel(item: item)
            dataModelList.append(streamModel)
        }
        
        return dataModelList
    }
    
    private func getVodDataList(dataDictionary: Array<Dictionary<String, Any>>) -> Array<VodDataModel> {
        var dataModelList: Array<VodDataModel> = []
        
        for item in dataDictionary {
            let vodModel = VodDataModel(item: item)
            dataModelList.append(vodModel)
        }
        
        return dataModelList
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
}
