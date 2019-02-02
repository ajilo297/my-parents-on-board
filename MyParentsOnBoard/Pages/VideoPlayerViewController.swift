//
//  VideoPlayerViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 29/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: BaseVideoPlayer {
    
    public var videoModels: [VideoDataModel]!
    private var currentIndex: Int = 0
    
    let playerViewController = AVPlayerViewController()
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerViewController.showsPlaybackControls = true
        play()
    }
    
    private func play() {
        
        let videoModel = videoModels[currentIndex]
        self.title = videoModel.videoName
        
        playerViewController.player?.pause()
        playerViewController.player = getPlayer()
        addPlayerToVideoView()
        playerViewController.view.frame = videoView.bounds
        playerViewController.player?.play()
    }
    
    private func getPlayer() -> AVPlayer? {
        guard let url = URL(string: videoModels[currentIndex].videoUrl) else {
            return nil
        }
        return AVPlayer(url: url)
    }
    
    private func addPlayerToVideoView() {
        if let viewWithTag = self.videoView.viewWithTag(100) {
            print("Removing old video from view")
            viewWithTag.removeFromSuperview()
        } else {
            print("No subview found with tag")
        }
        let view = playerViewController.view!
        view.tag = 100
        videoView.addSubview(view)
        
        playerViewController.player?.play()
    }
    
    private func playNext() {
        if currentIndex == videoModels.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    private func playPrevious() {
        if currentIndex == 0 {
            currentIndex = videoModels.count - 1
        } else {
            currentIndex -= 1
        }
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if videoModels.count <= 1 {
            return
        }
        if sender.direction == .left {
            playNext()
        } else if sender.direction == .right {
            playPrevious()
        }
        play()
    }
}
