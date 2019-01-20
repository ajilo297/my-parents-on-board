//
//  VodModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class VodDataModel: DataModel {
    public let videoUrl: String
    public let filebaseName: String
    public let thumbnailUrl: String
    public let vodName: String
    public let vodType: String
    
    public init(videoUrl: String, filebaseName: String, thumbnailUrl: String, vodName: String, vodType: String) {
        self.videoUrl = videoUrl
        self.filebaseName = filebaseName
        self.thumbnailUrl = thumbnailUrl
        self.vodName = vodName
        self.vodType = vodType
    }
}
