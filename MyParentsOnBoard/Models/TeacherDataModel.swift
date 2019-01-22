//
//  TeacherDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class TeacherDataModel : UserDataModel {
    
    private var professionalDetails: ProfessionalDetails
    
    init(id teacherId: Int, contactDetails: ContactDetails, personalDetails: PersonalDetails, professionalDetails: ProfessionalDetails) {
        self.professionalDetails = professionalDetails
        super.init(id: teacherId, contactDetails: contactDetails, personalDetails: personalDetails)
    }
    
    init(item: Dictionary<String, Any>) {
        let teacherIdValue = (item["teacherId"] as? Int) ?? -1
        let firstNameString = (item["firstName"] as? String) ?? ""
        let lastNameString = (item["lastName"] as? String) ?? ""
        let dateOfBirthString = (item["dateOfBirth"] as? String) ?? ""
        let emailString = (item["email"] as? String) ?? ""
        let phoneString = (item["phone"] as? String) ?? ""
        let positionString = (item["position"] as? String) ?? ""
        let workHoursString = (item["workHours"] as? String) ?? ""
        let educationString = (item["education"] as? String) ?? ""
        let certificationString = (item["certifications"] as? String) ?? ""
        let biographyString = (item["biography"] as? String) ?? ""
        let pictureUrlString = (item["pictureUrl"] as? String) ?? ""
        let ageValue = (item["age"] as? Int) ?? -1
        
        let contactDetailsValue = ContactDetails(email: emailString, phone: phoneString, pictureUrl: pictureUrlString)
        let personalDetailsValue = PersonalDetails(firstName: firstNameString, lastName: lastNameString, dateOfBirth: dateOfBirthString, age: ageValue, pictureUrl: pictureUrlString)
        let professionalDetailsValue = ProfessionalDetails(position: positionString, workHours: workHoursString, education: educationString, certifications: certificationString, biography: biographyString)
        
        self.professionalDetails = professionalDetailsValue
        super.init(id: teacherIdValue, contactDetails: contactDetailsValue, personalDetails: personalDetailsValue)
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
    
    public var dateOfBirth: String? {
        get {
            return personalDetails?.dateOfBirth
        }
    }
    
    public var age: Int? {
        get {
            return personalDetails?.age
        }
    }
    
    public var email: String? {
        get {
            return contactDetails?.email
        }
    }
    
    public var phone: String? {
        get {
            return contactDetails?.phone
        }
    }
    
    public var pictureUrl: String? {
        get {
            return personalDetails?.pictureUrl
        }
    }
    
    public var position: String {
        get {
            return professionalDetails.position
        }
    }
    
    public var workHours: String {
        get {
            return professionalDetails.workHours
        }
    }
    
    public var education: String {
        get {
            return professionalDetails.education
        }
    }
    
    public var certifications: String {
        get {
            return professionalDetails.certifications
        }
    }
    
    public var biography: String {
        get {
            return professionalDetails.biography
        }
    }
    
    class ProfessionalDetails {
        public let position: String
        public let workHours: String
        public let education: String
        public let certifications: String
        public let biography: String
        
        public init(position: String, workHours: String, education: String, certifications: String, biography: String) {
            self.position = position
            self.workHours = workHours
            self.education = education
            self.certifications = certifications
            self.biography = biography
        }
    }
}
