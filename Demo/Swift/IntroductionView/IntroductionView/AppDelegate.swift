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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Example 1
        var coverImageNames = ["img_index_01txt","img_index_02txt", "img_index_03txt"]
        var backgroundImageNames = ["img_index_01bg","img_index_02bg", "img_index_03bg"]
        self.introductionView = ZWIntroductionViewController(coverImageNames: coverImageNames, backgroundImageNames: backgroundImageNames)
        
        // Example 2
//        var enterButton: UIButton? = UIButton()
//        enterButton?.setBackgroundImage(UIImage(named: "bg_bar"), forState: UIControlState.Normal)
//        self.introductionView = ZWIntroductionViewController(coverImageNames: coverImageNames, backgroundImageNames: backgroundImageNames, button: enterButton)
        
        self.introductionView!.didSelectedEnter = {
            self.introductionView!.view.removeFromSuperview()
            self.introductionView = nil;
            
            // enter main view , write your code ...
//            self.viewController = UIViewController()
//            self.viewController?.view.backgroundColor = UIColor.whiteColor()
//            self.window?.rootViewController = self.viewController
        }
        
        self.window = UIWindow()
        self.window!.frame = UIScreen.mainScreen().bounds
        self.window?.makeKeyAndVisible()
        self.window?.addSubview(self.introductionView!.view)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

