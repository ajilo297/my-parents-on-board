//
//  ChildDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class ChildDataModel {
    public let childId: Int
    public let firstName: String
    public let lastName: String
    public let pictureUrl: String
    
    init(childId: Int, firstName: String, lastName: String, pictureUrl: String) {
        self.childId = childId
        self.firstName = firstName
        self.lastName = lastName
        self.pictureUrl = pictureUrl
    }
}
