What?
-----
Introduction View Controller

![Screenshot](https://github.com/squarezw/ZWIntroductionViewController/blob/master/screenshot.gif)

![Sample application screenshot](https://github.com/squarezw/ZWIntroductionViewController/blob/master/simple.gif "Screenshot of sample application on iPhone")

[![demo.png](https://github.com/squarezw/ZWIntroductionViewController/blob/master/demo.png  =50x60)](https://appetize.io/embed/3fce4yug3e1jxyvvuwgmvbkq0m)


Example Code?
-------------

A working sample iOS Xcode project is available in the `Demo` directory.

Usage?
----

Objective-C

    #import "ZWIntroductionViewController.h"
    
    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        ViewController *vc = [[ViewController alloc] init];
        self.window.rootViewController = vc;
        [_window makeKeyAndVisible];
    
        // Added Introduction View Controller
        NSArray *coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
        NSArray *backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames];
    
        // Example 1 : Simple
        //    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:backgroundImageNames];
    
        // Example 2 : Custom Button
        //    UIButton *enterButton = [UIButton new];
        //    [enterButton setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
        //    self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:backgroundImageNames button:enterButton];
    
        [self.window addSubview:self.introductionView.view];
    
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {        
            weakSelf.introductionView = nil;
        };
    
        return YES;
    }

Swift

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
 

Installation?
-------------

This project includes a `podspec` for usage with [CocoaPods](http://http://cocoapods.org/). Simply add

    pod 'ZWIntroductionViewController'

to your `Podfile` and run `pod install`.

Alternately, you can add all of the files contained in this project's `Library` directory to your Xcode project. If your project does not use ARC, you will need to enable ARC on these files. You can enabled ARC per-file by adding the -fobjc-arc flag, as described on [a common StackOverflow question](http://stackoverflow.com/questions/6646052/how-can-i-disable-arc-for-a-single-file-in-a-project).

License
-------

This project is licensed under the MIT license. All copyright rights are retained by myself.

Copyright (c) 2015 Square

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
