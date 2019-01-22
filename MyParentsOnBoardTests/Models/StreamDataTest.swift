//
//  StreamDataTest.swift
//  MyParentsOnBoardTests
//
//  Created by Ajil on 23/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import XCTest

@testable import MyParentsOnBoard

class StreamDataTest: XCTestCase {
    
    var streamModel: StreamDataModel!
    
    override func setUp() {
        streamModel = StreamDataModel(item: (["id":"1", "cameraurl":"someurl","thumburl":"someurl","streamtype":"hls", "cameraName":"front"]))
    }

    override func tearDown() {
        streamModel = nil
    }

    func testExample() {
        XCTAssertTrue(streamModel.id == "1")
        XCTAssertTrue(streamModel.streamType == "hls")
        XCTAssertTrue(streamModel.videoUrl == "someurl")
        XCTAssertTrue(streamModel.thumbnailUrl == "someurl")
        XCTAssertTrue(streamModel.videoName == "front")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
