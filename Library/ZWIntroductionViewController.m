//
//  LGIntroductionViewController.m
//
//  Created by square on 15/1/21.
//  Copyright (c) 2015年 square. All rights reserved.
//

#import "ZWIntroductionViewController.h"

@interface ZWIntroductionViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *backgroundViews;
@property (nonatomic, strong) NSArray *scrollViewPages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger centerPageIndex;

@property (nonatomic) NSURL *videoURL;
@property (nonatomic) AVPlayer *player;
@property (nonatomic) NSTimer *timer;

@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation ZWIntroductionViewController

@synthesize pageControlOffset = _pageControlOffset;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player pause];
    self.player = nil;
    [self stopTimer];
    self.view = nil;
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTimer
{
    if (self.autoScrolling) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    }
}

- (id)initWithCoverImageNames:(NSArray *)coverNames
{
    return [self initWithCoverImageNames:coverNames backgroundImageNames:nil button:nil];
}

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames
{
    return [self initWithCoverImageNames:coverNames backgroundImageNames:bgNames button:nil];
}

- (id)initWithCoverImageNames:(NSArray *)coverNames backgroundImageNames:(NSArray *)bgNames button:(UIButton *)button
{
    if (self = [super init]) {
        self.coverImageNames = coverNames;
        self.backgroundImageNames = bgNames;
        self.enterButton = button;
        [self initSelf];
    }
    return self;
}

- (id)initWithVideo:(NSURL *)videoURL
{
    return [self initWithVideo:videoURL volume:0.0];
}

- (id)initWithVideo:(NSURL *)videoURL volume:(float)volume
{
    if (self = [super init]) {
        self.videoURL = videoURL;
        self.volume = volume;
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    self.hiddenEnterButton = NO;
    self.autoScrolling = NO;
    self.autoLoopPlayVideo = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)applicationWillEnterForeground:(id)sender
{
    [self.player play];
}

#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addVideo];
    
    [self addBackgroundViews];
    
    self.pagingScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.pagingScrollView.delegate = self;
    self.pagingScrollView.pagingEnabled = YES;
    self.pagingScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:self.pagingScrollView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:[self frameOfPageControl]];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:self.pageControl];
    
    if (!self.enterButton) {
        self.enterButton = [UIButton new];
        [self.enterButton setTitle:NSLocalizedString(@"Enter", nil) forState:UIControlStateNormal];
        self.enterButton.layer.borderWidth = 0.5;
        self.enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        self.enterButton.hidden = self.hiddenEnterButton;
        self.enterButton.frame = [self frameOfEnterButton];
    }
    
    [self.enterButton addTarget:self action:@selector(enter:) forControlEvents:UIControlEventTouchUpInside];    
    self.enterButton.alpha = 0;
    [self.view addSubview:self.enterButton];
    
    [self reloadPages];
    
    [self.view addSubview:self.coverView];
    
    [self startTimer];
}

- (void)onTimer
{
    CGRect frame = self.pagingScrollView.frame;
    frame.origin.x = frame.size.width * (self.pageControl.currentPage + 1);
    frame.origin.y = 0;
    if (frame.origin.x >= self.pagingScrollView.contentSize.width) {
        frame.origin.x = 0;
    }
    [self.pagingScrollView scrollRectToVisible:frame animated:YES];
}

- (void)addBackgroundViews
{
    CGRect frame = self.view.bounds;
    NSMutableArray *tmpArray = [NSMutableArray new];
    [[[[self backgroundImageNames] reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:obj]];
        imageView.frame = frame;
        imageView.tag = idx + 1;
        [tmpArray addObject:imageView];
        [self.view addSubview:imageView];
    }];

    self.backgroundViews = [[tmpArray reverseObjectEnumerator] allObjects];
}

#pragma mark - Video

- (void)addVideo
{
    if (!self.videoURL) {
        return;
    }
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:self.videoURL];
    
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player.volume = self.volume;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    playerLayer.frame = self.view.layer.bounds;
    [self.view.layer addSublayer:playerLayer];
    
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
}

- (void)moviePlayDidEnd:(NSNotification*)notification{
    if (self.autoLoopPlayVideo) {
        // loop movie
        AVPlayerItem *item = [notification object];
        [item seekToTime:kCMTimeZero];
        [self.player play];
    } else {
        [self enter:nil];
    }
}


#pragma mark - load items

- (void)reloadPages
{
    self.pageControl.numberOfPages = [self numberOfPagesInPagingScrollView];
    self.pagingScrollView.contentSize = [self contentSizeOfScrollView];
    
    __block CGFloat x = 0;
    [[self scrollViewPages] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        obj.frame = CGRectOffset(obj.frame, x, 0);
        [self.pagingScrollView addSubview:obj];
        
        x += obj.frame.size.width;
    }];

    // fix enterButton can not presenting if ScrollView have only one page
    if (self.pageControl.numberOfPages == 1) {
        self.enterButton.alpha = 1;
        self.pageControl.alpha = 0;
    }
    
    // fix ScrollView can not scrolling if it have only one page
    if (self.pagingScrollView.contentSize.width == self.pagingScrollView.frame.size.width) {
        self.pagingScrollView.contentSize = CGSizeMake(self.pagingScrollView.contentSize.width + 1, self.pagingScrollView.contentSize.height);
    }
}

- (CGRect)frameOfPageControl
{
    CGRect orgFrame = CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 30);
    return CGRectOffset(orgFrame, self.pageControlOffset.x, self.pageControlOffset.y);
}

- (CGPoint)pageControlOffset
{
    if (CGPointEqualToPoint(_pageControlOffset, CGPointZero)) {
        return CGPointMake(0, -30);
    }
    return _pageControlOffset;
}

- (CGRect)frameOfEnterButton
{
    CGSize size = self.enterButton.bounds.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(self.view.frame.size.width * 0.6, 40);
    }
    return CGRectMake(self.view.frame.size.width / 2 - size.width / 2, self.pageControl.frame.origin.y - size.height, size.width, size.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.frame.size.width;
    CGFloat alpha = 1 - ((scrollView.contentOffset.x - index * self.view.frame.size.width) / self.view.frame.size.width);
    
    if ([self.backgroundViews count] > index) {
        UIView *v = [self.backgroundViews objectAtIndex:index];
        if (v) {
            [v setAlpha:alpha];
        }
    }
    
    self.pageControl.currentPage = scrollView.contentOffset.x / (scrollView.contentSize.width / [self numberOfPagesInPagingScrollView]);
    
    [self pagingScrollViewDidChangePages:scrollView];
    
    if (scrollView.isTracking) {
        [self stopTimer];
    } else {
        if (!self.timer) {
            [self startTimer];
        }
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView.panGestureRecognizer translationInView:scrollView.superview].x < 0) {
        if (![self hasNext:self.pageControl]) {
            [self enter:nil];
        }
    }
}

#pragma mark - UIScrollView & UIPageControl DataSource

- (BOOL)hasNext:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages > pageControl.currentPage + 1;
}

- (BOOL)isLast:(UIPageControl*)pageControl
{
    return pageControl.numberOfPages == pageControl.currentPage + 1;
}

- (NSInteger)numberOfPagesInPagingScrollView
{
    if (self.coverTitles) {
        return self.coverTitles.count;
    } else {
        return self.coverImageNames.count;
    }
}

- (void)pagingScrollViewDidChangePages:(UIScrollView *)pagingScrollView
{
    if (self.hiddenEnterButton) {
        return;
    }
    
    if ([self isLast:self.pageControl]) {
        if (self.pageControl.alpha == 1) {
            self.enterButton.alpha = 0;
            
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 1;
                self.pageControl.alpha = 0;
            }];
        }
    } else {
        if (self.pageControl.alpha == 0) {
            [UIView animateWithDuration:0.4 animations:^{
                self.enterButton.alpha = 0;
                self.pageControl.alpha = 1;
            }];
        }
    }
}

- (BOOL)hasEnterButtonInView:(UIView*)page
{
    __block BOOL result = NO;
    [page.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj && obj == self.enterButton) {
            result = YES;
        }
    }];
    return result;
}

- (UIView*)pageViewWithImageName:(NSString*)name
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    CGSize size = self.view.frame.size;
    imageView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, size.width, size.height);
    return imageView;
}

- (UIView*)pageViewWithTitle:(NSString*)title
{
    CGSize size = self.view.frame.size;
    CGRect rect;
    CGFloat height = 30;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending) {
        CGSize size = [title sizeWithAttributes:self.labelAttributes];
        height = size.height;
    }
    rect = CGRectMake(0, size.height + self.pageControlOffset.y - height, size.width, height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.textAlignment = NSTextAlignmentCenter;
    label.attributedText = [[NSAttributedString alloc] initWithString:title attributes:self.labelAttributes];
    return label;
}

- (NSArray*)scrollViewPages
{
    if ([self numberOfPagesInPagingScrollView] == 0) {
        return nil;
    }
    
    if (_scrollViewPages) {
        return _scrollViewPages;
    }
    
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    
    if (self.coverTitles) {
        [self.coverTitles enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [tmpArray addObject:[self pageViewWithTitle:obj]];
            
        }];
    } else if (self.coverImageNames) {
        [self.coverImageNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            [tmpArray addObject:[self pageViewWithImageName:obj]];
            
        }];
    }
    
    _scrollViewPages = tmpArray;
    
    return _scrollViewPages;
}

- (CGSize)contentSizeOfScrollView
{
    UIView *view = [[self scrollViewPages] firstObject];
    return CGSizeMake(view.frame.size.width * self.scrollViewPages.count, view.frame.size.height);
}

#pragma mark - Action

- (void)enter:(id)object
{
    [self stopTimer];

    if (self.didSelectedEnter) {
        self.didSelectedEnter();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end