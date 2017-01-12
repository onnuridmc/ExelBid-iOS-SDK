//
//  EBNativeAdViewController.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeAdViewController.h"
#import "EBNativeAdView.h"

#import <ExelBidSDK/ExelBidSDK.h>

@interface EBNativeAdViewController ()<UITextFieldDelegate, EBNativeAdDelegate>
@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;

@property (nonatomic, strong) EBNativeAd *nativeAd;

@end

@implementation EBNativeAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.keywordsTextField.text = self.info.ID;
    self.keywordsTextField.text = [EBConfig getNativeUnitId];
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

    [EBConfig setNativeUnitId:self.keywordsTextField.text];
    
    // Create and configure a renderer configuration for native ads.
    [ExelBidNativeManager initNativeAdWithAdUnitIdentifier:self.keywordsTextField.text adViewClass:[EBNativeAdView class]];
//    [ExelBidNativeManager testing:YES];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_keywordsTextField resignFirstResponder];
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    
    return YES;
}

#pragma mark - EBNativeAdDelegate

//광고 클릭시 호출 됩니다.
- (void)willLoadForNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Will Load for native ad.");
}

//광고 이동 완료시 호출 됩니다.
- (void)didLoadForNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Did Load for native ad.");
}

//광고로 이동시 호출 됩니다.
- (void)willLeaveApplicationFromNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"Will leave application from native ad.");
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}
@end
