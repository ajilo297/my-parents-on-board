//
//  VodModel.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

public class VodDataModel: VideoDataModel {
    public let filebaseName: String
    public let vodType: String
    
    public init(videoUrl: String, filebaseName: String, thumbnailUrl: String, vodName: String, vodType: String) {
        self.filebaseName = filebaseName
        self.vodType = vodType
        super.init(thumbnailUrl: thumbnailUrl, videoUrl: videoUrl, videoName: vodName)
    }
    
    public init(item: Dictionary<String, Any>) {
    
        let filebaseName = (item["filebasename"] as? String) ?? ""
        let vodType = (item["vodType"] as? String) ?? ""
        let videoUrl = (item["videourl"] as? String) ?? ""
        let thumbnailUrl = (item["thumbnailurl"] as? String) ?? ""
        let videoName = (item["vodName"] as? String) ?? ""
        
        self.filebaseName = filebaseName
        self.vodType = vodType
        super.init(thumbnailUrl: thumbnailUrl, videoUrl: videoUrl, videoName: videoName)
    }
}
