//
//  EBNativeAdCollectionViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 14..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeAdCollectionViewController.h"
#import "EBAdInfo.h"
#import "EBCollectionViewAdPlacerView.h"
#import <ExelBidSDK/ExelBidSDK.h>
#import <CoreLocation/CoreLocation.h>

@interface EBNativeAdCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, EBCollectionViewAdPlacerDelegate>

@property (nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic) NSMutableArray *contentItems;
@property (nonatomic) EBCollectionViewAdPlacer *placer;

@end

static NSString *const kReuseIdentifier = @"cell";

@implementation EBNativeAdCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake(70, 113);
    [self.collectionView setCollectionViewLayout:self.layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kReuseIdentifier];
    
    [self setupContent];
    [self setupAdPlacer];
}

#pragma mark - Content

- (void)setupContent
{
    self.contentItems = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 200; i++) {
        NSInteger r = arc4random() % 256;
        NSInteger g = arc4random() % 256;
        NSInteger b = arc4random() % 256;
        [self.contentItems addObject:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]];
    }
}

#pragma mark - AdPlacer

- (void)setupAdPlacer
{
    // Create a targeting object to serve better ads.
    EBNativeAdRequestTargeting *targeting = [EBNativeAdRequestTargeting targeting];
    targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdIconImageKey, kAdCTATextKey, nil];
    targeting.location = [[CLLocation alloc] initWithLatitude:37.7793 longitude:-122.4175];
    targeting.testing = YES;
    [targeting setYob:@"1976"];
    [targeting setGender:@"M"];
    
    // Create and configure a renderer configuration for native ads.
    EBStaticNativeAdRendererSettings *settings = [[EBStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [EBCollectionViewAdPlacerView class];
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(70.0f, 113.0f);
    };
    
    EBNativeAdRendererConfiguration *config = [EBStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
    
    // Create a collection view ad placer that uses server-side ad positioning.
    self.placer = [EBCollectionViewAdPlacer placerWithCollectionView:self.collectionView viewController:self rendererConfigurations:@[config]];
    
    // If you wish to use client-side ad positioning rather than configuring your ad unit on the
    // ExelBid website, comment out the line above and use the code below instead.
    
    /*
     // Create an ad positioning object and register the index paths where ads should be displayed.
     EBClientAdPositioning *positioning = [EBClientAdPositioning positioning];
     [positioning addFixedIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
     [positioning enableRepeatingPositionsWithInterval:15];
     
     self.placer = [EBCollectionViewAdPlacer placerWithCollectionView:self.collectionView viewController:self adPositioning:positioning rendererConfigurations:@[config]];
     */
    
    self.placer.delegate = self;
    // Load ads (using a test ad unit ID). Feel free to replace this ad unit ID with your own.
    [self.placer loadAdsForAdUnitID:self.info.ID targeting:targeting];
}

#pragma mark - <EBCollectionViewAdPlacerDelegate>

- (void)nativeAdWillLoadForCollectionViewAdPlacer:(EBCollectionViewAdPlacer *)placer
{
    NSLog(@"Collection view ad placer will Load.");
}

- (void)nativeAdDidLoadForCollectionViewAdPlacer:(EBCollectionViewAdPlacer *)placer
{
    NSLog(@"Collection view ad placer did Load.");
}

- (void)nativeAdWillLeaveApplicationFromCollectionViewAdPlacer:(EBCollectionViewAdPlacer *)placer
{
    NSLog(@"Collection view ad placer will leave application.");
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.contentItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * IMPORTANT: add the EB_ prefix to dequeueReusableCellWithReuseIdentifier:forIndexPath:.
     */
    UICollectionViewCell *cell = [collectionView EB_dequeueReusableCellWithReuseIdentifier:kReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = self.contentItems[indexPath.item];
    return cell;
}

@end
