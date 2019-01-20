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
    private var streamDataList: Array<StreamDataModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.liveVideoTableView.delegate = self
        self.liveVideoTableView.dataSource = self
        
        streamDataList = getDummyData()
    }
    
    private func getDummyData() -> Array<StreamDataModel> {
        return []
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
