//
//  LGIntroductionViewController.h
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void (^DidSelectedEnter)();

@interface ZWIntroductionViewController : UIViewController

@property (nonatomic, strong) UIScrollView *pagingScrollView;
@property (nonatomic, strong) UIButton *enterButton;
@property (nonatomic, assign) BOOL hiddenEnterButton; // default is NO
@property (nonatomic, assign) BOOL autoScrolling; // default is NO
@property (nonatomic, assign) BOOL autoLoopPlayVideo; // default is YES

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;

@property (nonatomic, strong) UIView *coverView; // default is nil

@property (nonatomic, assign) CGPoint pageControlOffset; // default is {0,-30}

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames;

/**
 @[@"make the world", @"the better place"]
 */
@property (nonatomic, strong) NSArray *coverTitles;
@property (nonatomic, strong) NSDictionary *labelAttributes;

// video volume
@property (nonatomic) float volume;

- (id)initWithCoverImageNames:(NSArray*)coverNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button;

// default volume is 0
- (id)initWithVideo:(NSURL*)videoURL;

- (id)initWithVideo:(NSURL*)videoURL volume:(float)volume;

@end
