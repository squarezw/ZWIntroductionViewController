//
//  LGIntroductionViewController.h
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ZWIntroductionView.h"

typedef void (^DidSelectedEnter)();

// Deprecated.
// This class has been replaced by the ZWIntroductionView to using

__deprecated
@interface ZWIntroductionViewController : UIViewController

@property (nonatomic, strong) ZWIntroductionView *introductionView;

// !!!: Following properties has been forwarded to the introductionView;
@property (nonatomic, strong) UIScrollView *pagingScrollView DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) UIButton *enterButton DEPRECATED_ATTRIBUTE;
@property (nonatomic, assign) BOOL hiddenEnterButton DEPRECATED_ATTRIBUTE; // default is NO
@property (nonatomic, assign) BOOL autoScrolling DEPRECATED_ATTRIBUTE; // default is NO DEPRECATED_ATTRIBUTE
@property (nonatomic, assign) BOOL autoLoopPlayVideo DEPRECATED_ATTRIBUTE; // default is YES DEPRECATED_ATTRIBUTE

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter DEPRECATED_ATTRIBUTE;

@property (nonatomic, strong) UIView *coverView DEPRECATED_ATTRIBUTE; // default is nil

@property (nonatomic, assign) CGPoint pageControlOffset DEPRECATED_ATTRIBUTE; // default is {0,-30}

/**
 @[@"image1", @"image2"]
 */
@property (nonatomic, strong) NSArray *backgroundImageNames DEPRECATED_ATTRIBUTE;

/**
 @[@"coverImage1", @"coverImage2"]
 */
@property (nonatomic, strong) NSArray *coverImageNames DEPRECATED_ATTRIBUTE;

/**
 @[@"make the world", @"the better place"]
 */
@property (nonatomic, strong) NSArray *coverTitles DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) NSDictionary *labelAttributes DEPRECATED_ATTRIBUTE;

// video volume
@property (nonatomic) float volume DEPRECATED_ATTRIBUTE;

// Deprecated:
// !!!: Following methods has been forwarded to the introductionView;

- (id)initWithCoverImageNames:(NSArray*)coverNames __deprecated;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames __deprecated;

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button __deprecated;

// default volume is 0
- (id)initWithVideo:(NSURL*)videoURL __deprecated;

- (id)initWithVideo:(NSURL*)videoURL volume:(float)volume __deprecated;

@end
