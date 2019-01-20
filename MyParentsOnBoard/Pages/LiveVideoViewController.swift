//
//  LiveVideoViewController.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 20/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import UIKit
import Kingfisher

class LiveVideoViewController: UIViewController {

    @IBOutlet public weak var liveVideoTableView: UITableView!
    private var streamDataList: Array<StreamModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liveVideoTableView.delegate = self
        self.liveVideoTableView.dataSource = self
        
        streamDataList = getDummyData()
    }
    
    private func getDummyData() -> Array<StreamModel> {
        
        var modelList: Array<StreamModel> = []
        modelList.append(StreamModel(id: "Cam1HDHLS", cameraUrl: "http://demo.myparentsonboard.com/live/cam1.m3u8?md5=0C_9LSpbQlzyk5SLAMd2Ww&expires=1547833309", thumbUrl: "http://demo.myparentsonboard.com/Thumbnails/Thumb_Cam2.jpg?md5=ct3vc09UxDx6ze9s2sY1oA&expires=1547833309", streamType: "HLS", cameraName: "Back Door View 1"))
        
        modelList.append(StreamModel(id: "Cam2HDHLS", cameraUrl: "http://demo.myparentsonboard.com/live/cam2.m3u8?md5=JrIyYJ_BSiUTfyJnc1XRKg&expires=1547833309", thumbUrl: "http://demo.myparentsonboard.com/Thumbnails/Thumb_Cam2.jpg?md5=ct3vc09UxDx6ze9s2sY1oA&expires=1547833309", streamType: "HLS", cameraName: "Front Corner View 1"))
        
        modelList.append(StreamModel(id: "Cam3HDHLS", cameraUrl: "http://demo.myparentsonboard.com/live/cam3.m3u8?md5=eAMPBa0sHgmf_HKef7KjqA&expires=1547833309", thumbUrl: "http://demo.myparentsonboard.com/Thumbnails/Thumb_Cam3.jpg?md5=XBAbR4AzyUpqUsmsT-NRoA&expires=1547833309", streamType: "HLS", cameraName: "Front Door View 1"))
        
        modelList.append(StreamModel(id: "Cam4HDHLS", cameraUrl: "http://demo.myparentsonboard.com/live/cam4.m3u8?md5=zMTS7iI9KO5L-SZBxrtAZg&expires=1547833309", thumbUrl: "http://demo.myparentsonboard.com/Thumbnails/Thumb_Cam4.jpg?md5=U-fMX-MXjri_NF0T61uLAQ&expires=1547833309", streamType: "HLS", cameraName: "Front Door View 1"))
        
        modelList.append(StreamModel(id: "Cam6HDHLS", cameraUrl: "http://demo.myparentsonboard.com/live/cam6.m3u8?md5=IQ0cFZXGPfMqjZoziOUCUQ&expires=1547833309", thumbUrl: "http://demo.myparentsonboard.com/Thumbnails/Thumb_Cam6.jpg?md5=pQbe_FECWVHpx5TyQ_ou5A&expires=1547833309", streamType: "HLS", cameraName: "Kitchen"))
        
        return modelList
    }
}

extension LiveVideoViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.streamDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let streamData = streamDataList[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "live_video_cell") as? LiveVideoTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        guard let imageUrl = URL(string: "https://cdn2.techadvisor.co.uk/cmsdata/features/3511087/how-to-fix-youtube-videos-that-wont-play_thumb800.jpg") else {
            return UITableViewCell(style: .default, reuseIdentifier: nil)
        }
        
        cell.labelText.text = streamData.cameraName
        cell.thumbnailImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholderImage"))
        
        return cell
    }
}
