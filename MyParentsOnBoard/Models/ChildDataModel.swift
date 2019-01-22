//
//  ChildDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class ChildDataModel: UserDataModel {
    
    override init(id childId: Int, contactDetails: ContactDetails?, personalDetails: PersonalDetails?) {
        super.init(id: childId, contactDetails: contactDetails, personalDetails: personalDetails)
    }
    
    init(item: Dictionary<String, Any>) {
        let childIdValue = (item["childId"] as? Int) ?? -1
        let firstNameString = (item["firstName"] as? String) ?? ""
        let lastNameString = (item["lastName"] as? String) ?? ""
        let pictureUrlString = (item["pictureUrl"] as? String) ?? ""
        
        let personalDetailsValue = PersonalDetails(firstName: firstNameString, lastName: lastNameString, dateOfBirth: "", age: -1, pictureUrl: pictureUrlString)
        
        super.init(id: childIdValue, contactDetails: nil, personalDetails: personalDetailsValue)
    }
    
    public var childId: Int {
        get {
           return id
        }
    }
    
    public var firstName: String? {
        get {
            return personalDetails?.firstName
        }
    }
    
    public var lastName: String? {
        get {
            return personalDetails?.lastName
        }
    }
    
    public var pictureUrl: String? {
        get {
            return personalDetails?.pictureUrl
        }
    }
}
