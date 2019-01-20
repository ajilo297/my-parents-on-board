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
