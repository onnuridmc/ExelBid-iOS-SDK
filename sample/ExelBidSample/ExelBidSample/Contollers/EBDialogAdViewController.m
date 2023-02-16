//
//  EBDialogAdViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 15..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBDialogAdViewController.h"
#import <ExelBidSDK/ExelBidSDK.h>

#import "EBNativeAdView.h"
#import "EBNativeAd2View.h"

#import "EBHTMLDialogView.h"
#import "EBNativeDialogView.h"
#import "EBNativeRoundView.h"

@interface EBDialogAdViewController ()<UITextFieldDelegate,EBAdViewDelegate,EBNativeAdDelegate>


@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField1;
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField2;
@property (weak, nonatomic) IBOutlet UIButton *loadHTMLAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showHTMLAdButton;
@property (weak, nonatomic) IBOutlet UIButton *loadNativeAdButton1;
@property (weak, nonatomic) IBOutlet UIButton *showNativeAdButton1;
@property (weak, nonatomic) IBOutlet UIButton *loadNativeAdButton2;
@property (weak, nonatomic) IBOutlet UIButton *showNativeAdButton2;
@property (weak, nonatomic) IBOutlet UILabel *failLabel;

@property (nonatomic, strong) EBHTMLDialogView *htmlDialogView;
@property (nonatomic, strong) EBNativeDialogView *nativeDialogView;
@property (nonatomic, strong) EBNativeRoundView *nativeRoundView;

@property (nonatomic, strong) EBAdView *adView;
@property (nonatomic, strong) EBNativeAd *nativeAd;

@end

@implementation EBDialogAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.keywordsTextField1.text = [self.info.ID componentsSeparatedByString:@","][0] ;
    self.keywordsTextField2.text = [self.info.ID componentsSeparatedByString:@","][1] ;
    [self.loadHTMLAdButton.layer setCornerRadius:3.0f];
    [self.showHTMLAdButton.layer setCornerRadius:3.0f];
    [self.loadNativeAdButton1.layer setCornerRadius:3.0f];
    [self.showNativeAdButton1.layer setCornerRadius:3.0f];
    [self.loadNativeAdButton2.layer setCornerRadius:3.0f];
    [self.showNativeAdButton2.layer setCornerRadius:3.0f];
    [self buttonReset];
    
    self.htmlDialogView = [[EBHTMLDialogView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    self.nativeDialogView = [[EBNativeDialogView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
    self.nativeRoundView = [[EBNativeRoundView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTapHTMLLoadButton:(id)sender
{
    [self.keywordsTextField1 endEditing:YES];
    
    [self buttonReset];
    self.loadHTMLAdButton.enabled = NO;
    self.failLabel.hidden = YES;
    
    
    if (self.adView) {
        [self.adView removeFromSuperview];
    }
    
    self.adView = [[EBAdView alloc] initWithAdUnitId:self.keywordsTextField1.text size:self.htmlDialogView.adView.bounds.size];
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.adView.delegate = self;
    [self.adView setYob:@"1976"];
    [self.adView setGender:@"M"];
    [self.adView setTesting:YES];
    [self.htmlDialogView.adView addSubview:self.adView];
    [self.adView loadAd];
}

- (IBAction)didTapHTMLShowButton:(id)sender
{
    [self.navigationController.view addSubview:self.htmlDialogView];
}

- (IBAction)didTapNativeLoadButton1:(id)sender
{
    [self.keywordsTextField1 endEditing:YES];
    
    [self buttonReset];
    self.loadNativeAdButton1.enabled = NO;
    self.failLabel.hidden = YES;
    
    [self clearAd1];
    [self nativeAdLoad:1];
    
}

- (IBAction)didTapNativeShowButton1:(id)sender
{
    
    [[self.nativeDialogView.adView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *adView = [self.nativeAd retrieveAdViewWithError:nil];
    [self.nativeDialogView.adView addSubview:adView];
    adView.frame = self.nativeDialogView.adView.bounds;

    [self.navigationController.view addSubview:self.nativeDialogView];
}

- (IBAction)didTapNativeLoadButton2:(id)sender
{
    [self.keywordsTextField1 endEditing:YES];
    
    [self buttonReset];
    self.loadNativeAdButton2.enabled = NO;
    self.failLabel.hidden = YES;
  
    [self clearAd2];
    [self nativeAdLoad:2];
}

- (IBAction)didTapNativeShowButton2:(id)sender
{
    [[self.nativeRoundView.adView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *adView = [self.nativeAd retrieveAdViewWithError:nil];
    [self.nativeRoundView.adView addSubview:adView];
    adView.frame = self.nativeRoundView.adView.bounds;
    
    [self.navigationController.view addSubview:self.nativeRoundView];
}

- (void)nativeAdLoad:(NSInteger)type {
    // Create and configure a renderer configuration for native ads.
    EBStaticNativeAdRendererSettings *settings = [[EBStaticNativeAdRendererSettings alloc] init];
    if (type == 1) {
        settings.renderingViewClass = [EBNativeAdView class];
    }else{
        settings.renderingViewClass = [EBNativeAd2View class];
    }
   
    EBNativeAdRendererConfiguration *config = [EBStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings];
    
    
    EBNativeAdRequest *adRequest = [EBNativeAdRequest requestWithAdUnitIdentifier:self.keywordsTextField2.text rendererConfigurations:@[config]];
    EBNativeAdRequestTargeting *targeting = [[EBNativeAdRequestTargeting alloc] init];
    targeting.testing = YES;
    [targeting setYob:@"1976"];
    [targeting setGender:@"M"];
    adRequest.targeting = targeting;
    
    [adRequest startWithCompletionHandler:^(EBNativeAdRequest *request, EBNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"================> %@", error);
            [self configureAdLoadFail];
        } else {
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            if (type == 1) {
                self.loadNativeAdButton1.enabled = YES;
                self.showNativeAdButton1.hidden = NO;
            }else{
                self.loadNativeAdButton2.enabled = YES;
                self.showNativeAdButton2.hidden = NO;
            }
            NSLog(@"Received Native Ad");
        }
    }];

}

- (void)buttonReset {
    self.showHTMLAdButton.hidden = YES;
    self.showNativeAdButton1.hidden = YES;
    self.showNativeAdButton2.hidden = YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_keywordsTextField1 resignFirstResponder];
    [_keywordsTextField2 resignFirstResponder];
}

- (void)clearAd1
{
    [[self.nativeDialogView.adView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.nativeAd = nil;
    self.failLabel.hidden = YES;
}

- (void)clearAd2
{
    [[self.nativeRoundView.adView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.nativeAd = nil;
    self.failLabel.hidden = YES;
}

- (void)configureAdLoadFail
{
    self.loadNativeAdButton1.enabled = YES;
    self.loadNativeAdButton2.enabled = YES;
    self.failLabel.hidden = NO;
}

#pragma mark - 
#pragma mark EBAdViewDelegate
- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoadAd:(EBAdView *)view
{
    self.loadHTMLAdButton.enabled = YES;
    self.showHTMLAdButton.hidden = NO;
}

- (void)adViewDidFailToLoadAd:(EBAdView *)view
{
    self.loadHTMLAdButton.enabled = YES;
    self.failLabel.hidden = NO;
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


@end
