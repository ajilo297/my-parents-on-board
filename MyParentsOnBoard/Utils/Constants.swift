//
//  Constants.swift
//  MyParentsOnBoard
//
//  Created by Ajil on 21/01/19.
//  Copyright © 2019 ATS. All rights reserved.
//

import Foundation

class Constants {
    
    // ViewController Identifiers
    public static let logiViewControllerIdentifier: String = "LoginViewController"
    public static let videoPlayerViewControllerIdentifier: String = "VideoPlayerViewController"
    
    // Segue Identifiers
    public static let homeToVideoIdentifier: String = "home_to_live_video"
    public static let loginToNavigationIdentifier: String = "login_to_navigation"
    public static let splashToLoginIdentifier: String = "splash_to_login"
    public static let spalshToNavigationIdentifier: String = "splash_to_navigation"
    public static let homeToLoginIdentifier: String = "home_to_login"
    
    // TableViewCell Reuse identifiers
    public static let videoTableViewCellReuseIdentifier = "video_cell"

    // Page titles
    public static let liveVideoPageTitle: String = "Live Video"
    public static let specialEventsPageTitle: String = "Special Event"
    
    // API URLs
    public static let baseUrl: String = "http://app.myparentsonboard.com/mpob-cloud/app/mobile/login"
}
