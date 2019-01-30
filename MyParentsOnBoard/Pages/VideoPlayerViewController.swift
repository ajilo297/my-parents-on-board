//
//  VideoPlayerViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 29/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    
    public var videoUrls: [URL]!
    private var currentIndex: Int = 0
    
    let smallVideoPlayerViewController = AVPlayerViewController()
    
    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallVideoPlayerViewController.showsPlaybackControls = true
        play()
    }
    
    private func play() {
        smallVideoPlayerViewController.player?.pause()
        smallVideoPlayerViewController.player = getPlayer()
        addPlayerToVideoView()
        smallVideoPlayerViewController.view.frame = videoView.bounds
        smallVideoPlayerViewController.player?.play()
    }
    
    private func getPlayer() -> AVPlayer {
        return AVPlayer(url: videoUrls[currentIndex])
    }
    
    private func addPlayerToVideoView() {
        if let viewWithTag = self.videoView.viewWithTag(100) {
            print("Removing old video from view")
            viewWithTag.removeFromSuperview()
        } else {
            print("No subview found with tag")
        }
        let view = smallVideoPlayerViewController.view!
        view.tag = 100
        videoView.addSubview(view)
        
        smallVideoPlayerViewController.player?.play()
    }
    
    private func playNext() {
        if currentIndex == videoUrls.count - 1 {
            currentIndex = 0
        } else {
            currentIndex += 1
        }
    }
    
    private func playPrevious() {
        if currentIndex == 0 {
            currentIndex = videoUrls.count - 1
        } else {
            currentIndex -= 1
        }
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            playNext()
        } else if sender.direction == .right {
            playPrevious()
        }
        play()
    }
}
