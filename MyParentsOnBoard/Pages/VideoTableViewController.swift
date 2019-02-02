//
//  LiveVideoViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher
import AVKit
import NYT360Video

class VideoTableViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet public weak var videoTableView: UITableView!
    private var videoDataList: Array<VideoDataModel> = []
    private var currentIndex: Int!

    public var pageTitle: String?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoTableView.delegate = self
        self.videoTableView.dataSource = self
        
        self.title = pageTitle ?? "Video List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = pageTitle ?? "Video List"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.title = pageTitle ?? "Video List"
        
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.default
        nav?.tintColor = UIColor.blue
        nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        getData()
        videoTableView.reloadData()
    }
    
    private func getData() {
        guard let title = self.title else {
            return
        }
        
        guard let appDelegate = getApplicationDelegate() else {
            return
        }
        
        if title == Constants.liveVideoPageTitle {
            videoDataList = CoredataManager.getStreamData(context: getContext(appDelegate: appDelegate))
        } else if title == Constants.specialEventsPageTitle {
            videoDataList = CoredataManager.getVodData(context: getContext(appDelegate: appDelegate))
        }
    }
    
    private func getContext(appDelegate: AppDelegate) -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    private func getApplicationDelegate() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
}

extension VideoTableViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoData = videoDataList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.videoTableViewCellReuseIdentifier) as? VideoTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        cell.labelText.text = videoData.videoName
        
        if let imageUrl = URL(string: videoData.thumbnailUrl) {
            cell.thumbnailImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        } else {
            cell.thumbnailImage.image = UIImage(named: "placeholderImage")
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        
        let videoModel = videoDataList[currentIndex]
        
        guard let _ = URL(string: videoModel.videoUrl) else {
            return
        }
        
        if let vod = videoModel as? VodDataModel {
            if vod.vodType == "360" {
                loadVideoTo360Player(video: vod)
            } else {
                playVideo(index: currentIndex)
            }
        } else {
            playVideo(index: currentIndex)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func loadVideoTo360Player(video: VideoDataModel) {
        guard let videoUrl = URL(string: video.videoUrl) else {
            return
        }
        let player = AVPlayer(url: videoUrl)
        let motionManager: NYT360MotionManager = NYT360MotionManager.shared()
        let vc = ThreeSixtyPlayerViewController(avPlayer: player, motionManager: motionManager)
        vc.title = video.videoName
        self.show(vc, sender: self)
        vc.play()
    }
    
    private func arrangeVideoQueue(selectedIndex: Int) -> [VideoDataModel] {
        var list = videoDataList
        var i = 0;
        
        while i < selectedIndex {
            let video = list.remove(at: 0)
            list.append(video)
            i += 1
        }
        
        var videoList: Array<VideoDataModel> = []
        for video in list {
            videoList.append(video)
        }
        
        var normalVideoList: [VideoDataModel] = []
        for video in videoList {
            if let vod = video as? VodDataModel {
                if vod.vodType == "Normal" {
                    normalVideoList.append(vod)
                }
            } else {
                normalVideoList.append(video)
            }
        }
        
        return normalVideoList
    }
    
    private func playVideo(index: Int) {
        let videoList = arrangeVideoQueue(selectedIndex: index)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.videoPlayerViewControllerIdentifier) as? VideoPlayerViewController else {
            print("Cannot instantiate Video player")
            return
        }
        
        vc.videoModels = videoList
        self.show(vc, sender: self)
    }
}
