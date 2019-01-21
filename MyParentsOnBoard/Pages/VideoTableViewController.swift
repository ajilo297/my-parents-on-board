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
        
        guard let url = URL(string: videoModel.videoUrl) else {
            return
        }
        
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.present(playerViewController, animated: true, completion: {
            playerViewController.player!.play()
        })
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
