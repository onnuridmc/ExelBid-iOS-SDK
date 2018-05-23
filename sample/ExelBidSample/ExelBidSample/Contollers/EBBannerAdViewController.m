//
//  EBBannerAdViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBBannerAdViewController.h"
#import <ExelBidSDK/ExelBidSDK.h>

@interface EBBannerAdViewController ()<UITextFieldDelegate,EBAdViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;

@property (nonatomic, strong) EBAdView *adView;

@end

@implementation EBBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.keywordsTextField.text = self.info.ID;
    self.keywordsTextField.text = [EBConfig getBannerUnitId];
    [self.loadAdButton.layer setCornerRadius:3.0f];

   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadAdClicked:(id)sender
{
    if (self.adView) {
        [self.adView removeFromSuperview];
    }
    [_keywordsTextField resignFirstResponder];
    
    [EBConfig setBannerUnitId:self.keywordsTextField.text];
    
    self.adView = [[EBAdView alloc] initWithAdUnitId:self.keywordsTextField.text size:_adViewContainer.bounds.size];
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.adView.delegate = self;
    [self.adView setYob:@"1976"];
    [self.adView setGender:@"M"];
    [self.adView setTesting:NO];
    [self.adView setFullWebView:YES];
    [_adViewContainer addSubview:self.adView];
     [self.adView loadAd];
    
    _spinner.hidden = NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_keywordsTextField resignFirstResponder];
}

#pragma mark-
#pragma mark EBAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

//광고가 로딩된 시점에 호출 됩니다.
- (void)adViewDidLoadAd:(EBAdView *)view
{
    _spinner.hidden = YES;
}

//서버로부터 광고를 가져오지 못한 경우에 호출 됩니다.
- (void)adViewDidFailToLoadAd:(EBAdView *)view
{
    _spinner.hidden = YES;
}

//광고 클릭시 호출 됩니다.
- (void)willLoadViewForAd:(EBAdView *)view {
    
}


@end
