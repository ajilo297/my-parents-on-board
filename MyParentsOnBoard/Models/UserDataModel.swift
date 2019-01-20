//
//  UserDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class UserDataModel: DataModel {
    
    internal var id: Int
    internal var contactDetails: ContactDetails?
    internal var personalDetails: PersonalDetails?
    
    init(id: Int, contactDetails: ContactDetails?, personalDetails: PersonalDetails?) {
        self.id = id
        self.contactDetails = contactDetails
        self.personalDetails = personalDetails
    }
    
    public class ContactDetails {
        public let email: String
        public let phone: String
        
        public init(email: String, phone: String, pictureUrl: String) {
            self.email = email
            self.phone = phone
        }
    }
    
    public class PersonalDetails {
        public let firstName: String
        public let lastName: String
        public let dateOfBirth: String
        public let age: Int
        public let pictureUrl: String
        
        public init(firstName: String, lastName: String, dateOfBirth: String, age: Int, pictureUrl: String) {
            self.firstName = firstName
            self.lastName = lastName
            self.dateOfBirth = dateOfBirth
            self.age = age
            self.pictureUrl = pictureUrl
        }
    }
}
