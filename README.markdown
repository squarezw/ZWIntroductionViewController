What?
-----
**Introduction View**

It will display a fullscreen swipeable modal window to guide the user through a welcome screen / tutorial


- Video

![Screenshot](https://github.com/squarezw/ZWIntroductionViewController/blob/master/video.gif)

- Cover

![Screenshot](https://github.com/squarezw/ZWIntroductionViewController/blob/master/screenshot.gif)


- Simple Version

![Sample application screenshot](https://github.com/squarezw/ZWIntroductionViewController/blob/master/simple.gif "Screenshot of sample application on iPhone")

<a href='https://appetize.io/embed/29xabc89e2u0j8uh3y0dkkk0yg' alt='Live demo'>
    <img width="50" height="60" src="demo.png"/>
</a>


Usage?
----

### Swift


```
        // data source
        self.coverImageNames = ["img_index_01txt","img_index_02txt", "img_index_03txt"]
        self.backgroundImageNames = ["img_index_01bg","img_index_02bg", "img_index_03bg"]
        self.coverTitles = ["MAKE THE WORLD", "THE BETTER PLACE"]
        
        let filePath = NSBundle.mainBundle().pathForResource("intro_video", ofType: "mp4")
        self.videoURL = NSURL.fileURLWithPath(filePath!)
        
        // Added Introduction View
        
//        self.introductionView = self.simpleIntroductionView()
        
//        self.introductionView = self.coverImagesIntroductionView()
        
//        self.introductionView = self.customButtonIntroductionView()
        
        self.introductionView = self.videoIntroductionView();
        
//        self.introductionView = self.advanceIntroductionView();
        
        self.window?.addSubview(self.introductionView)
        
        self.introductionView!.didSelectedEnter = {
            self.introductionView!.removeFromSuperview()
            self.introductionView = nil;
            // enter main view , write your code ...
        }
        
    // Example 1 : Simple
    func simpleIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(coverImageNames: self.backgroundImageNames)
        return vc
    }

    // Example 2 : Cover Images
    func coverImagesIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames)
        return vc
    }
    
    // Example 3 : Custom Button
    func customButtonIntroductionView() -> ZWIntroductionView {
        let enterButton = UIButton()
        enterButton.setBackgroundImage(UIImage(named: "bg_bar"), forState: .Normal)
        enterButton.setTitle("Login", forState: .Normal)
        let vc = ZWIntroductionView(coverImageNames: self.coverImageNames, backgroundImageNames: self.backgroundImageNames, button: enterButton)
        return vc
    }
    
    // Example 4 : Video
    func videoIntroductionView() -> ZWIntroductionView {
        let vc = ZWIntroductionView(video: self.videoURL)
        vc.coverImageNames = self.coverImageNames
        vc.autoScrolling = true
        return vc
    }
    
    // Example 5 : Advance
    func advanceIntroductionView() -> ZWIntroductionView {
        let loginButton = UIButton(frame: CGRectMake(3, self.window!.frame.size.height - 60, self.window!.frame.size.width - 6, 50))
        loginButton.backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        loginButton.setTitle("Login", forState: .Normal)
        let vc = ZWIntroductionView(video: self.videoURL, volume: 0.7)
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
            
```

### Objective-C

```
	// data source

    self.coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    self.backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    self.coverTitles = @[@"MAKE THE WORLD", @"THE BETTER PLACE"];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intro_video" ofType:@"mp4"];
    self.videoURL = [NSURL fileURLWithPath:filePath];

    // Added Introduction View
    
//    self.introductionView = [self simpleIntroductionView];
    
//    self.introductionView = [self coverImagesIntroductionView];
    
//    self.introductionView = [self customButtonIntroductionView];
    
    self.introductionView = [self videoIntroductionView];
    
//    self.introductionView = [self advanceIntroductionView];

    
    [self.window addSubview:self.introductionView];
    
    __weak AppDelegate *weakSelf = self;
    self.introductionView.didSelectedEnter = ^() {
        [weakSelf.introductionView removeFromSuperview];
        weakSelf.introductionView = nil;
    };
```

> Take a look at the Example project to see how to use customization using more

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
