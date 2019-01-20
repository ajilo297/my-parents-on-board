//
//  StreamModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class StreamDataModel: DataModel {
    public let id: String
    public let cameraUrl: String
    public let thumbUrl: String
    public let streamType: String
    public let cameraName: String
    
    public init(id: String, cameraUrl: String, thumbUrl: String, streamType: String, cameraName: String) {
        self.cameraName = cameraName
        self.id = id
        self.thumbUrl = thumbUrl
        self.cameraUrl = cameraUrl
        self.streamType = streamType
    }
}
