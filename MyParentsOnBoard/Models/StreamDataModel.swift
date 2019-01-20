//
//  StreamModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class StreamDataModel: VideoDataModel {
    public let id: String
    public let streamType: String
    
    public init(id: String, cameraUrl: String, thumbUrl: String, streamType: String, cameraName: String) {
        self.id = id
        self.streamType = streamType
        super.init(thumbnailUrl: thumbUrl, videoUrl: cameraUrl, videoName: cameraName)
    }
}
