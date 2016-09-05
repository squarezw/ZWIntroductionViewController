//
//  AppDelegate.m
//  IntroductionView
//
//  Created by square on 15/2/16.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWIntroductionViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@property (nonatomic, strong) NSArray *coverImageNames;

@property (nonatomic, strong) NSArray *backgroundImageNames;

@property (nonatomic, strong) NSArray *coverTitles;

@property (nonatomic, strong) NSURL *videoURL;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    [_window makeKeyAndVisible];

    // data source
    self.coverImageNames = @[@"img_index_01txt", @"img_index_02txt", @"img_index_03txt"];
    self.backgroundImageNames = @[@"img_index_01bg", @"img_index_02bg", @"img_index_03bg"];
    self.coverTitles = @[@"MAKE THE WORLD", @"THE BETTER PLACE"];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"intro_video" ofType:@"mp4"];
    self.videoURL = [NSURL fileURLWithPath:filePath];

    // Added Introduction View Controller
    
//    self.introductionView = [self simpleIntroductionView];
    
//    self.introductionView = [self coverImagesIntroductionView];
    
//    self.introductionView = [self customButtonIntroductionView];
    
    self.introductionView = [self videoIntroductionView];
    
//    self.introductionView = [self advanceIntroductionView];

    
    [self.window addSubview:self.introductionView.view];
    
    __weak AppDelegate *weakSelf = self;
    self.introductionView.didSelectedEnter = ^() {        
        weakSelf.introductionView = nil;
    };
    
    return YES;
}

// Example 1 : Simple
- (ZWIntroductionViewController *)simpleIntroductionView
{
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithCoverImageNames:self.backgroundImageNames];
    return vc;
}

// Example 2 : Custom Button
- (ZWIntroductionViewController *)coverImagesIntroductionView
{
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithCoverImageNames:self.coverImageNames backgroundImageNames:self.backgroundImageNames];
    return vc;
}

// Example 3 : Custom Button
- (ZWIntroductionViewController *)customButtonIntroductionView
{
    UIButton *enterButton = [UIButton new];
    [enterButton setBackgroundImage:[UIImage imageNamed:@"bg_bar"] forState:UIControlStateNormal];
    [enterButton setTitle:@"Login" forState:UIControlStateNormal];
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithCoverImageNames:self.coverImageNames backgroundImageNames:self.backgroundImageNames button:enterButton];
    return vc;
}

// Example 4 : Video
- (ZWIntroductionViewController *)videoIntroductionView
{
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithVideo:self.videoURL volume:0.7];
    vc.coverImageNames = self.coverImageNames;
    vc.autoScrolling = YES;
    return vc;
}

// Example 5 : Advance
- (ZWIntroductionViewController *)advanceIntroductionView
{
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(3, self.window.frame.size.height - 60, self.window.frame.size.width - 6, 50)];
    loginButton.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithVideo:self.videoURL volume:0.7];
    vc.coverImageNames = self.coverImageNames;
    vc.autoScrolling = YES;
    vc.hiddenEnterButton = YES;
    vc.pageControlOffset = CGPointMake(0, -100);
    vc.labelAttributes = @{ NSFontAttributeName : [UIFont fontWithName:@"Arial-BoldMT" size:28.0],
                                               NSForegroundColorAttributeName : [UIColor whiteColor] };
    vc.coverView = loginButton;
    
    vc.coverTitles = self.coverTitles;
    
    return vc;
}
@end
