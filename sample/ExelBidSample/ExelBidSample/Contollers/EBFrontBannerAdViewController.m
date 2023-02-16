//
//  EBFrontBannerAdViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 4..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBFrontBannerAdViewController.h"
#import <ExelBidSDK/ExelBidSDK.h>

@interface EBFrontBannerAdViewController ()<EBInterstitialAdControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (nonatomic, strong) EBInterstitialAdController *interstitial;
@end

@implementation EBFrontBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.showAdButton.hidden = YES;
    self.keywordsTextField.text = self.info.ID;
    [self.loadAdButton.layer setCornerRadius:3.0f];
    [self.showAdButton.layer setCornerRadius:3.0f];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLoadButton:(id)sender
{
    [self.keywordsTextField endEditing:YES];
    
    self.spinner.hidden = NO;
    self.showAdButton.hidden = YES;
    self.loadAdButton.enabled = NO;
    self.failLabel.hidden = YES;
    
//    self.interstitial.keywords = self.keywordsTextField.text;
    
//    self.info.keywords = self.interstitial.keywords;
    // persist last used keywords if this is a saved ad
//    if ([[EBAdPersistenceManager sharedManager] savedAdForID:self.info.ID] != nil) {
//        [[EBAdPersistenceManager sharedManager] addSavedAd:self.info];
//    }
    
    self.interstitial = [EBInterstitialAdController interstitialAdControllerForAdUnitId:self.keywordsTextField.text];
    self.interstitial.delegate = self;

     [self.interstitial setYob:@"1976"];
     [self.interstitial setGender:@"M"];
     [self.interstitial setTesting:YES];
     [self.interstitial loadAd];
}

- (IBAction)didTapShowButton:(id)sender
{
    [self.interstitial showFromViewController:self];
}

#pragma mark - <EBInterstitialAdControllerDelegate>

- (void)interstitialDidLoadAd:(EBInterstitialAdController *)interstitial
{
    self.spinner.hidden = YES;
    self.showAdButton.hidden = NO;
    self.loadAdButton.enabled = YES;
}

- (void)interstitialDidFailToLoadAd:(EBInterstitialAdController *)interstitial
{
    self.failLabel.hidden = NO;
    self.loadAdButton.enabled = YES;
    self.spinner.hidden = YES;
}

- (void)interstitialDidExpire:(EBInterstitialAdController *)interstitial
{
    self.loadAdButton.enabled = YES;
    self.showAdButton.hidden = YES;
    self.spinner.hidden = YES;
}

- (void)interstitialWillAppear:(EBInterstitialAdController *)interstitial
{
}

- (void)interstitialDidAppear:(EBInterstitialAdController *)interstitial
{
}

- (void)interstitialWillDisappear:(EBInterstitialAdController *)interstitial
{
}

- (void)interstitialDidDisappear:(EBInterstitialAdController *)interstitial
{
    self.showAdButton.hidden = YES;
}

- (void)interstitialDidReceiveTapEvent:(EBInterstitialAdController *)interstitial
{
}

@end
