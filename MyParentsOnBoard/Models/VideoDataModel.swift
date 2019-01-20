//
//  VideoDataModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class VideoDataModel: DataModel {
    internal var thumbnailUrl: String
    internal var videoUrl: String
    internal var videoName: String
    
    init(thumbnailUrl: String, videoUrl: String, videoName: String) {
        self.thumbnailUrl = thumbnailUrl
        self.videoUrl = videoUrl
        self.videoName = videoName
    }
}
