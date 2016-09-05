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
    var introductionView: ZWIntroductionViewController?
    var viewController: UIViewController?
    
    var coverImageNames: [AnyObject]?
    var backgroundImageNames: [AnyObject]?
    var coverTitles: [AnyObject]?
    var videoURL: NSURL?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        self.window!.frame = UIScreen.mainScreen().bounds
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UIViewController()
        
        // Example 1
        self.coverImageNames = ["img_index_01txt","img_index_02txt", "img_index_03txt"]
        self.backgroundImageNames = ["img_index_01bg","img_index_02bg", "img_index_03bg"]
        self.coverTitles = ["MAKE THE WORLD", "THE BETTER PLACE"]
        
        let filePath = NSBundle.mainBundle().pathForResource("intro_video", ofType: "mp4")
        self.videoURL = NSURL.fileURLWithPath(filePath!)
        
        // Added Introduction View Controller
        
//        self.introductionView = self.simpleIntroductionView()
        
//        self.introductionView = self.coverImagesIntroductionView()
        
//        self.introductionView = self.customButtonIntroductionView()
        
        self.introductionView = self.videoIntroductionView();
        
//        self.introductionView = self.advanceIntroductionView();
        
        self.window?.addSubview(self.introductionView!.view)
        
        self.introductionView!.didSelectedEnter = {
            self.introductionView!.view.removeFromSuperview()
            self.introductionView = nil;
            // enter main view , write your code ...
        }
        
        return true
    }

    // Example 1 : Simple
    func simpleIntroductionView() -> ZWIntroductionViewController {
        let vc = ZWIntroductionViewController(coverImageNames: self.backgroundImageNames)
        return vc
    }

    // Example 2 : Custom Button
    func coverImagesIntroductionView() -> ZWIntroductionViewController {
        let vc = ZWIntroductionViewController(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames)
        return vc
    }
    
    // Example 3 : Custom Button
    func customButtonIntroductionView() -> ZWIntroductionViewController {
        let enterButton = UIButton()
        enterButton.setBackgroundImage(UIImage(named: "bg_bar"), forState: .Normal)
        enterButton.setTitle("Login", forState: .Normal)
        let vc = ZWIntroductionViewController(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames, button: enterButton)
        return vc
    }
    
    // Example 4 : Video
    func videoIntroductionView() -> ZWIntroductionViewController {
        let vc = ZWIntroductionViewController(video: self.videoURL)
        vc.coverImageNames = self.coverImageNames
        vc.autoScrolling = true
        return vc
    }
    
    // Example 5 : Advance
    func advanceIntroductionView() -> ZWIntroductionViewController {
        let loginButton = UIButton(frame: CGRectMake(3, self.window!.frame.size.height - 60, self.window!.frame.size.width - 6, 50))
        loginButton.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        loginButton.setTitle("Login", forState: .Normal)
        let vc = ZWIntroductionViewController(video: self.videoURL, volume: 0.7)
        vc.coverImageNames = self.coverImageNames
        vc.autoScrolling = true
        vc.hiddenEnterButton = true
        vc.pageControlOffset = CGPointMake(0, -100)
        vc.labelAttributes = [NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 28.0)!,
                              NSForegroundColorAttributeName: UIColor.whiteColor()]
        vc.coverView = loginButton
        
        vc.coverTitles = self.coverTitles
        
        return vc
    }

}

