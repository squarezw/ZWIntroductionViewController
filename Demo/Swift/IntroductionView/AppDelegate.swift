//
//  AppDelegate.swift
//  IntroductionView
//
//  Created by square on 15/3/16.
//  Copyright (c) 2015年 square. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var introductionView: ZWIntroductionView!
    var viewController: UIViewController?
    
    var coverImageNames: [String]?
    var backgroundImageNames: [String]?
    var coverTitles: [String]?
    var videoURL: URL?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.makeKeyAndVisible()
        
        // You could add a empty View Controoler like this one or build a 
        // ZWIntroductionViewController as Welcome page.  
        // if you used ZWIntroductionViewController class, pls have a look 
        // ZWIntroductionViewController API,  most of them are same with below
        // initialized method of ZWIntroductionView
        self.window?.rootViewController = UIViewController()
        
        // data source
        self.coverImageNames = ["img_index_01txt","img_index_02txt", "img_index_03txt"]
        self.backgroundImageNames = ["img_index_01bg","img_index_02bg", "img_index_03bg"]
        self.coverTitles = ["MAKE THE WORLD", "THE BETTER PLACE"]
        
        let filePath = Bundle.main.path(forResource: "intro_video", ofType: "mp4")
        self.videoURL = URL(fileURLWithPath: filePath!)
        
        // Added Introduction View
        
//        self.introductionView = self.simpleIntroductionView()
        
//        self.introductionView = self.coverImagesIntroductionView()
        
//        self.introductionView = self.customButtonIntroductionView()
        
//        self.introductionView = self.videoIntroductionView();
        
        self.introductionView = self.advanceIntroductionView();
        
        self.window?.addSubview(self.introductionView)
        
        self.introductionView.didSelectedEnter = {
            self.introductionView!.removeFromSuperview()
            self.introductionView = nil;
            // enter main view , write your code ...
            // self.window.rootViewController = your root view controller
        }
        
        return true
    }
    
    // Example 1 : Simple
    func simpleIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(coverImageNames: self.backgroundImageNames)!
        return vc
    }

    // Example 2 : Cover Images
    func coverImagesIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames)!
        return vc
    }
    
    // Example 3 : Custom Button
    func customButtonIntroductionView() -> ZWIntroductionView {
        let enterButton = UIButton()
        enterButton.setBackgroundImage(UIImage(named: "bg_bar"), for: UIControlState())
        enterButton.setTitle("Login", for: UIControlState())
        let vc = ZWIntroductionView(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames, button: enterButton)!
        return vc
    }
    
    // Example 4 : Video
    func videoIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(video: self.videoURL)!
        vc.coverImageNames = self.coverImageNames
        vc.autoScrolling = true
        return vc
    }
    
    // Example 5 : Advance
    func advanceIntroductionView() -> ZWIntroductionView {
        let loginButton = UIButton(frame: CGRect(x: 3, y: self.window!.frame.size.height - 60, width: self.window!.frame.size.width - 6, height: 50))
        loginButton.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        loginButton.setTitle("Login", for: UIControlState())
//        loginButton.addTarget(self, action: #selector(<#the function that could close welcome page#>), for: .touchUpInside)
        let vc = ZWIntroductionView(video: self.videoURL, volume: 0.7)!
        vc.coverImageNames = self.coverImageNames
        vc.autoScrolling = true
        vc.hiddenEnterButton = true
        vc.pageControlOffset = CGPoint(x: 0, y: -100)
        vc.labelAttributes = [NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 28.0)!,
                              NSForegroundColorAttributeName: UIColor.white]
        vc.coverView = loginButton
        
        vc.coverTitles = self.coverTitles
        
        return vc
    }

}

