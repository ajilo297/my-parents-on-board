//
//  LiveVideoViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import Kingfisher

class VideoTableViewController: UIViewController {

    @IBOutlet public weak var videoTableView: UITableView!
    private var videoDataList: Array<VideoDataModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.videoTableView.delegate = self
        self.videoTableView.dataSource = self
        
        videoDataList = getDummyData()
        videoTableView.reloadData()
    }
    
    private func getDummyData() -> Array<StreamDataModel> {
        var dataList: Array<StreamDataModel> = []
        dataList.append(StreamDataModel(id: "1", cameraUrl: "", thumbUrl: "", streamType: "", cameraName: "Main Camera 1"))
        dataList.append(StreamDataModel(id: "2", cameraUrl: "", thumbUrl: "", streamType: "", cameraName: "Main Camera 2"))
        dataList.append(StreamDataModel(id: "2", cameraUrl: "", thumbUrl: "", streamType: "", cameraName: "Main Camera 3"))
        return dataList
    }
}

extension VideoTableViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videoData = videoDataList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "live_video_cell") as? VideoTableViewCell else {
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
}
