//
//  ErrorManager.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class ErrorManager {
    public static let urlNotParsed = ErrorModel(message: "Unable to parse URL", code: 140)
    public static let jsonNotParsed = ErrorModel(message: "Unable to parse JSON", code: 141)
}
