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
    
    private static func makeGetRequest(url: URL, header: Dictionary<String, String>?, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        runHttpSession(urlRequest: urlRequest, callback: {(data, response, error) in
            callback(data, response, error)
        })
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
        
        runHttpSession(urlRequest: urlRequest, callback: {(data, response, error) in
            callback(data, response, error)
        })
    }
    
    private static func runHttpSession(urlRequest: URLRequest, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            callback(data, response, error)
        })
        
        task.resume()
    }
    
    public static func loginWith(emailId: String, password: String, callback: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let userDictionary = ["userName": "\(emailId)", "password": "\(password)"]
        
        guard let url = URL(string: baseUrl) else {
            callback(nil, nil, NSError(domain: ErrorManager.urlNotParsed.message , code: ErrorManager.urlNotParsed.code, userInfo: nil))
            return
        }
        
        guard let userJsonData = try? JSONSerialization.data(withJSONObject: userDictionary, options: .prettyPrinted) else {
            callback(nil, nil, NSError(domain: ErrorManager.jsonNotParsed.message, code: ErrorManager.jsonNotParsed.code, userInfo: nil))
            return
        }

        makePostRequest(url: url, header: ["Content-Type": "application/json"], body: userJsonData, callback: {data, response, error in
            callback(data, response, error)
        })
    }
    
    public static func getTeacherDetails(id: String) {
        guard let url = URL(string: "someUrl/\(id)") else {
            return
        }
        makeGetRequest(url: url, header: nil, callback: {(data, response, error) in
            print("\(data!)")
        })
    }
}
