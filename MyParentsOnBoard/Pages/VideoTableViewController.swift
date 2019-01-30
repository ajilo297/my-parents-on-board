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
        let videoModel = videoDataList[indexPath.row]
        
        currentIndex = indexPath.row
        
        guard let _ = URL(string: videoModel.videoUrl) else {
            return
        }
        
        playVideo(index: currentIndex)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func arrangeVideoQueue(selectedIndex: Int) -> [URL] {
        var list = videoDataList
        var i = 0;
        
        while i < selectedIndex {
            let video = list.remove(at: 0)
            list.append(video)
            i += 1
        }
        
        var urlList: Array<URL> = []
        for video in list {
            if let url = URL(string: video.videoUrl) {
                urlList.append(url)
            }
        }
        
        return urlList
    }
    
    private func playVideo(index: Int) {
        let urlList = arrangeVideoQueue(selectedIndex: index)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Constants.videoPlayerViewControllerIdentifier) as? VideoPlayerViewController else {
            print("Cannot instantiate Video player")
            return
        }
        
        vc.videoUrls = urlList
        self.show(vc, sender: self)
    }
}
