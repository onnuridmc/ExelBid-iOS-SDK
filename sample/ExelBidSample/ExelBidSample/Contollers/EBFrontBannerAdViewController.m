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
//    self.keywordsTextField.text = self.info.ID;
    self.keywordsTextField.text = [EBConfig getFrontBannerUnitId];
    [self.loadAdButton.layer setCornerRadius:3.0f];
    [self.showAdButton.layer setCornerRadius:3.0f];


    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapLoadButton:(id)sender
{
    [EBConfig setFrontBannerUnitId:self.keywordsTextField.text];
    
    self.interstitial = [EBInterstitialAdController interstitialAdControllerForAdUnitId:self.keywordsTextField.text];
    self.interstitial.delegate = self;

    [self.keywordsTextField endEditing:YES];
    
    self.spinner.hidden = NO;
    self.showAdButton.hidden = YES;
    self.loadAdButton.enabled = NO;
    self.failLabel.hidden = YES;
    

    [self.interstitial setYob:@"1976"];
    [self.interstitial setGender:@"M"];
//    [self.interstitial setTesting:YES];
    [self.interstitial loadAd];
}

- (IBAction)didTapShowButton:(id)sender
{
    [self.interstitial showFromViewController:self];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_keywordsTextField resignFirstResponder];
}

#pragma mark - <EBInterstitialAdControllerDelegate>
//광고가 로딩된 시점에 호출 됩니다.
- (void)interstitialDidLoadAd:(EBInterstitialAdController *)interstitial
{
    self.spinner.hidden = YES;
    self.showAdButton.hidden = NO;
    self.loadAdButton.enabled = YES;
}

//서버로부터 광고를 가져오지 못한 경우에 호출 됩니다.
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

//전면 광고가 사용자에게 노출된 시작시 호출됩니다
- (void)interstitialWillAppear:(EBInterstitialAdController *)interstitial
{
}

//전면 광고가 사용자에게 노출된 시점에 호출됩니다.
- (void)interstitialDidAppear:(EBInterstitialAdController *)interstitial
{
}

 //사용자가 전면광고를 닫는 시점에 호출 됩니다.
- (void)interstitialWillDisappear:(EBInterstitialAdController *)interstitial
{
}

//전면광고가 닫힌 후 호출 됩니다.
- (void)interstitialDidDisappear:(EBInterstitialAdController *)interstitial
{
    self.showAdButton.hidden = YES;
}

//광고 클릭시 호출 됩니다.
- (void)interstitialDidReceiveTapEvent:(EBInterstitialAdController *)interstitial
{
}

@end
