//
//  TeacherDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class TeacherDataModel {
    public let teacherId: Int
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: String
    public let email: String
    public let phone: String
    public let position: String
    public let workHours: String
    public let education: String
    public let certifications: String
    public let biography: String
    public let pictureUrl: String
    public let age: Int
    
    init(teacherId: Int, firstName: String, lastName: String, dateOfBirth: String, email: String, phone: String, position: String,  workHours: String, education: String, certifications: String, biography: String, pictureUrl: String, age: Int) {
        self.teacherId = teacherId
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.email = email
        self.phone = phone
        self.position = position
        self.workHours = workHours
        self.education = education
        self.certifications = certifications
        self.biography = biography
        self.pictureUrl = pictureUrl
        self.age = age
    }
}
