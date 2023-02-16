//
//  EBNativeAdTableViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 11..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeAdTableViewController.h"

#import "EBTableViewAdPlacerView.h"
#import <ExelBidSDK/ExelBidSDK.h>
#import <CoreLocation/CoreLocation.h>

static NSString *kDefaultCellIdentifier = @"ExelBidSampleAppTableViewAdPlacerCell";

@interface EBNativeAdTableViewController ()<UITableViewDelegate,UITableViewDataSource,EBTableViewAdPlacerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentItems;
@property (nonatomic, strong) EBTableViewAdPlacer *placer;

@end


@implementation EBNativeAdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.contentItems = [NSMutableArray array];
    
    if ([self.tableView respondsToSelector:@selector(registerClass:forCellReuseIdentifier:)]) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kDefaultCellIdentifier];
    }
    
    [self setupContent];
    [self setupAdPlacer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Content

- (void)setupContent
{
    self.contentItems = [NSMutableArray array];
    
    for (int i = 0; i < 100; i++) {
        NSString *itemString = [NSString stringWithFormat:@"Item %d",i];
        [self.contentItems addObject:itemString];
    }
    
}

#pragma mark - AdPlacer

- (void)setupAdPlacer
{
    // Create a targeting object to serve better ads.
    EBNativeAdRequestTargeting *targeting = [EBNativeAdRequestTargeting targeting];
    targeting.location = [[CLLocation alloc] initWithLatitude:37.7793 longitude:-122.4175];
    targeting.desiredAssets = [NSSet setWithObjects:kAdIconImageKey,
                               kAdMainImageKey,
                               kAdCTATextKey,
                               kAdTextKey,
                               kAdTitleKey,
                               nil];
    targeting.testing = YES;
    [targeting setYob:@"1976"];
    [targeting setGender:@"M"];
    [targeting setTesting:YES];
    
    // Create and configure a renderer configuration.
    
    // Static native ads
    EBStaticNativeAdRendererSettings *nativeAdSettings = [[EBStaticNativeAdRendererSettings alloc] init];
    nativeAdSettings.renderingViewClass = [EBTableViewAdPlacerView class];
    nativeAdSettings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth, 330.0f);
    };
    EBNativeAdRendererConfiguration *nativeAdConfig = [EBStaticNativeAdRenderer rendererConfigurationWithRendererSettings:nativeAdSettings];
  
    // Create a table view ad placer that uses server-side ad positioning.
    self.placer = [EBTableViewAdPlacer placerWithTableView:self.tableView viewController:self rendererConfigurations:@[nativeAdConfig]];
    self.placer.delegate = self;
    // Load ads (using a test ad unit ID). Feel free to replace this ad unit ID with your own.
    [self.placer loadAdsForAdUnitID:self.info.ID targeting:targeting];
}

#pragma mark - UITableViewAdPlacerDelegate

- (void)nativeAdWillLoadForTableViewAdPlacer:(EBTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer will Load.");
}

- (void)nativeAdDidLoadForTableViewAdPlacer:(EBTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer did Load.");
}

- (void)nativeAdWillLeaveApplicationFromTableViewAdPlacer:(EBTableViewAdPlacer *)placer
{
    NSLog(@"Table view ad placer will leave application.");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.contentItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * IMPORTANT: add the EB_ prefix to dequeueReusableCellWithReuseIdentifier:forIndexPath:.
     */
    UITableViewCell *cell = [tableView EB_dequeueReusableCellWithIdentifier:kDefaultCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDefaultCellIdentifier];
    }
    
    NSString *fontName = self.contentItems[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.textLabel.text = fontName;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * IMPORTANT: add the EB_ prefix to deselectRowAtIndexPath:animated:.
     */
    [tableView EB_deselectRowAtIndexPath:indexPath animated:YES];
}

@end
