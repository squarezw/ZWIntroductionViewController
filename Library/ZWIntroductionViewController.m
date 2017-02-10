//
//  LGIntroductionViewController.m
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import "ZWIntroductionViewController.h"

@implementation ZWIntroductionViewController

- (void)dealloc
{
    [self.introductionView removeFromSuperview];
     self.introductionView = nil;
}

// -- Properties

- (UIScrollView *)pagingScrollView {
    return self.introductionView.pagingScrollView;
}

- (void)setPagingScrollView:(UIScrollView *)pagingScrollView
{
    self.introductionView.pagingScrollView = pagingScrollView;
}

- (UIButton *)enterButton {
    return self.introductionView.enterButton;
}

- (void)setEnterButton:(UIButton *)enterButton {
    self.introductionView.enterButton = enterButton;
}

- (BOOL)hiddenEnterButton {
    return self.introductionView.hiddenEnterButton;
}

- (void)setHiddenEnterButton:(BOOL)hiddenEnterButton {
    self.introductionView.hiddenEnterButton = hiddenEnterButton;
}

- (BOOL)autoScrolling {
    return self.introductionView.autoScrolling;
}

- (void)setAutoScrolling:(BOOL)autoScrolling {
    self.introductionView.autoScrolling = autoScrolling;
}

- (BOOL)autoLoopPlayVideo {
    return self.introductionView.autoLoopPlayVideo;
}

- (void)setAutoLoopPlayVideo:(BOOL)autoLoopPlayVideo {
    self.introductionView.autoLoopPlayVideo = autoLoopPlayVideo;
}

- (UIView *)coverView {
    return self.introductionView.coverView;
}

- (void)setCoverView:(UIView *)coverView {
    self.introductionView.coverView = coverView;
}

- (CGPoint)pageControlOffset {
    return self.introductionView.pageControlOffset;
}

- (void)setPageControlOffset:(CGPoint)pageControlOffset {
    self.introductionView.pageControlOffset = pageControlOffset;
}

- (NSArray *)backgroundImageNames {
    return self.introductionView.backgroundImageNames;
}

- (void)setBackgroundImageNames:(NSArray *)backgroundImageNames {
    self.introductionView.backgroundImageNames = backgroundImageNames;
}

- (NSArray *)coverImageNames {
    return self.introductionView.coverImageNames;
}

- (void)setCoverImageNames:(NSArray *)coverImageNames {
    self.introductionView.coverImageNames = coverImageNames;
}

- (NSArray *)coverTitles {
    return self.introductionView.coverTitles;
}

- (void)setCoverTitles:(NSArray *)coverTitles {
    self.introductionView.coverTitles = coverTitles;
}

- (NSDictionary *)labelAttributes {
    return self.introductionView.labelAttributes;
}

- (void)setLabelAttributes:(NSDictionary *)labelAttributes {
    self.introductionView.labelAttributes = labelAttributes;
}

- (float)volume {
    return self.introductionView.volume;
}

- (void)setVolume:(float)volume {
    self.introductionView.volume = volume;
}

- (DidSelectedEnter)didSelectedEnter {
    return self.introductionView.didSelectedEnter;
}

- (void)setDidSelectedEnter:(DidSelectedEnter)didSelectedEnter
{
    self.introductionView.didSelectedEnter = didSelectedEnter;
}

// View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.introductionView];
    self.introductionView.didSelectedEnter = self.didSelectedEnter;
}

- (id)initWithCoverImageNames:(NSArray*)coverNames
{
    return [self initWithCoverImageNames:coverNames backgroundImageNames:nil button:nil];
}

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames
{
    return [self initWithCoverImageNames:coverNames backgroundImageNames:bgNames button:nil];
}

- (id)initWithCoverImageNames:(NSArray*)coverNames backgroundImageNames:(NSArray*)bgNames button:(UIButton*)button
{
    if (self = [super init]) {
        self.introductionView = [[ZWIntroductionView alloc ] initWithCoverImageNames:coverNames backgroundImageNames:bgNames button:button];
    }
    return self;
}

- (id)initWithVideo:(NSURL*)videoURL
{
    return [self initWithVideo:videoURL volume:0.0];
}

- (id)initWithVideo:(NSURL*)videoURL volume:(float)volume
{
    if (self = [super init]) {
        self.introductionView = [[ZWIntroductionView alloc ] initWithVideo:videoURL volume:volume];
    }
    return self;
}


@end

