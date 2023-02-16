//
//  EBNativeBannerAdViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 10..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeBannerAdViewController.h"
#import <ExelBidSDK/ExelBidSDK.h>

#import "EBNativeBannerAdView.h"

@interface EBNativeBannerAdViewController ()<UITextFieldDelegate, EBNativeAdDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;

@property (nonatomic, strong) EBNativeAd *nativeAd;

@end

@implementation EBNativeBannerAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.keywordsTextField.text = self.info.ID;
    [self.loadAdButton.layer setCornerRadius:3.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loadAdClicked:(id)sender
{
    [self.keywordsTextField endEditing:YES];
    
    self.loadAdButton.enabled = NO;
    [self.spinner setHidden:NO];
    [self clearAd];
    
    // Create and configure a renderer configuration for native ads.
    [ExelBidNativeManager initNativeAdWithAdUnitIdentifier:self.keywordsTextField.text adViewClass:[EBNativeBannerAdView class]];
    [ExelBidNativeManager testing:YES];
    [ExelBidNativeManager yob:@"1976"];
    [ExelBidNativeManager gender:@"M"];
    
    [ExelBidNativeManager startWithCompletionHandler:^(EBNativeAdRequest *request, EBNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"================> %@", error);
            [self configureAdLoadFail];
        } else {
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            [self displayAd];
            NSLog(@"Received Native Ad");
        }
        [self.spinner setHidden:YES];
    }];
    
}

- (void)clearAd
{
    [[self.adViewContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.nativeAd = nil;
    self.failLabel.hidden = YES;
}

- (void)displayAd
{
    self.loadAdButton.enabled = YES;
    
    [[self.adViewContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *adView = [self.nativeAd retrieveAdViewWithError:nil];
    [self.adViewContainer addSubview:adView];
    adView.frame = self.adViewContainer.bounds;
}

- (void)configureAdLoadFail
{
    self.loadAdButton.enabled = YES;
    self.failLabel.hidden = NO;
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}

#pragma mark - EBNativeAdDelegate

- (void)willLoadForNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Will Load for native ad.");
}

- (void)didLoadForNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Did Load for native ad.");
}

- (void)willLeaveApplicationFromNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Will leave application from native ad.");
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

@end
