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
        print("LOGIN REQUEST: \(Constants.currentTime())")
        HttpManager.loginWith(emailId: emailId, password: password, callback: {
            (data, response, error) in
            print("LOGIN RESPONSE: \(Constants.currentTime())")
            self.dismissLoadingDialog(loadingDialog, data: data, response: response, error: error)
        })
    }
    
    private func dismissLoadingDialog(_ loadingDialog: UIAlertController, data: Data?, response: URLResponse?, error: Error?) {
        DispatchQueue.main.async {
            loadingDialog.dismiss(animated: true, completion: {
                self.handleLoginResponse(data: data, response: response, error: error)
            })
        }
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
        print("JSON PARSE INITIALISING REQUEST: \(Constants.currentTime())")
        do {
            guard let dataDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                return
            }
            getDataFromDictionary(dataDictionary: dataDictionary)
        } catch _ as NSError {
            return
        }
    }
    
    private func getDataFromDictionary(dataDictionary: Dictionary<String, Any>) {
        
        let streamArrayList = parseStreamData(dataDictionary: dataDictionary)
        let vodArrayList = parseVodData(dataDictionary: dataDictionary)
        let teacherArrayList = parseTeacherData(dataDictionary: dataDictionary)
        let childArrayList = parseChildData(dataDictionary: dataDictionary)
        
        let streamList: Array<StreamDataModel> = getStreamDataList(dataDictionary: streamArrayList)
        let vodList: Array<VodDataModel> = getVodDataList(dataDictionary: vodArrayList)
        let teacherList = getTeacherDataList(dataDictionary: teacherArrayList)
        let childList = getChildDataList(dataDictionary: childArrayList)
        
        print("CORE DATA SAVE STARTED: \(Constants.currentTime())")
        
        for streamModel in streamList {
            saveDataModel(dataModel: streamModel)
        }
        
        for vodModel in vodList {
            saveDataModel(dataModel: vodModel)
        }
        
        for childModel in childList {
            saveDataModel(dataModel: childModel)
        }
        
        for teacherModel in teacherList {
            saveDataModel(dataModel: teacherModel)
        }
        
        print("CORE DATA SAVE COMPLETED: \(Constants.currentTime())")
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.loginToNavigationIdentifier, sender: self)
        }
    }
    
    private func parseStreamData(dataDictionary: Dictionary<String, Any>) -> Array<Dictionary<String, String>>{
        
        guard let streamObject = dataDictionary["nginxStreams"] as? Dictionary<String, Any> else {
            print("Error 101")
            return []
        }
        
        guard let streamArrayList = streamObject["streams"] as? Array<Dictionary<String, String>> else {
            print("Error 102")
            return []
        }
        
        return streamArrayList
    }
    
    private func parseVodData(dataDictionary: Dictionary<String, Any>) -> Array<Dictionary<String, Any>>{
        
        guard let vodObject = dataDictionary["onDemandVideos"] as? Dictionary<String, Any> else {
            print("Error 103")
            return []
        }
        
        guard let vodArrayList = vodObject["vods"] as? Array<Dictionary<String, Any>> else {
            print("Error 104")
            return []
        }
        
        return vodArrayList
    }
    
    private func parseTeacherData(dataDictionary: Dictionary<String, Any>) -> Array<Dictionary<String, Any>> {
        guard let teacherObject = dataDictionary["teachers"] as? Dictionary<String, Any> else {
            print("Error 105")
            return []
        }
        
        guard let teacherArrayList = teacherObject["data"] as? Array<Dictionary<String, Any>> else {
            print("Error 106")
            return []
        }
        
        return teacherArrayList
    }
    
    private func parseChildData(dataDictionary: Dictionary<String, Any>) -> Array<Dictionary<String, Any>>{
        
        guard let childObject = dataDictionary["children"] as? Dictionary<String, Any> else {
            print("Error 107")
            return []
        }
        
        guard let childArrayList = childObject["data"] as? Array<Dictionary<String, Any>> else {
            print("Error 108")
            return []
        }
        
        return childArrayList
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
    
    private func getTeacherDataList(dataDictionary: Array<Dictionary<String, Any>>) -> Array<TeacherDataModel> {
        var dataModelList: Array<TeacherDataModel> = []
        
        for item in dataDictionary {
            let teacherModel = TeacherDataModel(item: item)
            dataModelList.append(teacherModel)
        }
        
        return dataModelList
    }
    
    private func getChildDataList(dataDictionary: Array<Dictionary<String, Any>>) -> Array<ChildDataModel> {
        var dataModelList: Array<ChildDataModel> = []
        
        for item in dataDictionary {
            let childModel = ChildDataModel(item: item)
            dataModelList.append(childModel)
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
