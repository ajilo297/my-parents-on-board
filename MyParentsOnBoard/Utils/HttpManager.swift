//
//  HttpManager.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 18/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class HttpManager {
    
    private static let baseUrl = "http://app.myparentsonboard.com/mpob-cloud/app/mobile/login"
    
    private static func makeGetRequest(url: URL, header: Dictionary<String, String>?, callback: (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            
        })
        
        task.resume()
    }
    
    private static func makePostRequest(url: URL, header: Dictionary<String, String>?, body: Data, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        urlRequest.httpBody = body
        
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            callback(data, response, error)
        })
        
        task.resume()
    }
    
    public static func loginWith(emailId: String, password: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let userDictionary = ["userName": "\(emailId)", "password": "\(password)"]
        
        guard let url = URL(string: baseUrl) else {
            return
        }
        
        guard let userJsonData = try? JSONSerialization.data(withJSONObject: userDictionary, options: .prettyPrinted) else {
            return
        }

        makePostRequest(url: url, header: ["Content-Type": "application/json"], body: userJsonData, callback: {data, response, error in
            callback(data, response, error)
        })
    }
}