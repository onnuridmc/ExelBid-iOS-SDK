//
//  EBMediationBannerAdViewController.m
//
//  Created by Jaeuk Jeong on 2023/02/09.
//

#import "EBMediationBannerAdViewController.h"
#import <ExelBidSDK/ExelBidSDK.h>

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdFitSDK/AdFitSDK.h>

@interface EBMediationBannerAdViewController ()<UITextFieldDelegate, EBAdViewDelegate, AdFitBannerAdViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (nonatomic, strong) EBMediationInfo *mediationInfo;
@property (nonatomic, strong) EBAdView *adView;
@property (nonatomic, strong) AdFitBannerAdView *bannerAdView;

@end

@implementation EBMediationBannerAdViewController

@synthesize mediationInfo = _mediationInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.showAdButton.hidden = YES;
    self.keywordsTextField.text = self.info.ID;
    [self.loadAdButton.layer setCornerRadius:3.0f];
    [self.showAdButton.layer setCornerRadius:3.0f];
    
    // 광고 요청하기 전에 사용자로 부터 개인정보 보호에 관한 권한을 요청해야 합니다.
    // (앱이 설치되고 한번만 호출하면 되며, 아래 코드는 사용자가 권한에 대한 응답 후에는 더 이상 사용자에게 권한을 묻지 않습니다.)
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 권한 요청이 완료된 다음, 광고를 요청해 주세요.
            // loadAd()
        }];
    }
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
    self.logView.text = @"";
    
    // ExelBid 미디에이션 연동
    [ExelBidMediationManager initMediationWithAdUnitIdentifier:self.keywordsTextField.text];
    
    // ExelBid 미디에이션 테스트 설정
    [ExelBidMediationManager testing:YES];
    
    // ExelBid 미디에이션 타입 설정
    [ExelBidMediationManager mediationTypes: [NSSet setWithObjects:EBMediationTypeExelbid, EBMediationTypeAdfit, nil]];
    
    // ExelBid 미디에이션 콜백
    [ExelBidMediationManager startWithCompletionHandler:^(EBMediationRequest *request, EBMediationInfo *response, NSError *error) {
        if (error) {
            NSLog(@"================> %@", error);
        } else {
            self.showAdButton.hidden = NO;
            
            // ExelBid 미디에이션 정보 객체
            self.mediationInfo = response;

            self.logView.text = [NSString stringWithFormat:@"%@\nMediation List Size : %ld", self.logView.text, [self.mediationInfo size]];
        }
        
        self.spinner.hidden = YES;
        self.loadAdButton.enabled = YES;
    }];
}

- (IBAction)didTapShowButton:(id)sender
{
    [self loadMediation];
}

- (void)loadMediation
{
    // ExelBid 미디에이션 객체 체크
    if (self.mediationInfo != nil) {
        // adViewContainer 내 추가된 서브뷰 제거
        //        [_adViewContainer removeFromSuperview];
        [[self.adViewContainer subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        // ExelBid 미디에이션 순서대로 가져오기 (더이상 없으면 nil)
        EBMediation *mediation = [self.mediationInfo next];
        
        self.logView.text = [NSString stringWithFormat:@"%@\nMediation Id : %@, Unit Id : %@", self.logView.text, mediation.type, mediation.unit_id];
        
        if ([mediation.type isEqualToString:EBMediationTypeExelbid]) {
            [self loadExelBid:mediation];
        } else if ([mediation.type isEqualToString:EBMediationTypeAdfit]) {
            [self loadAdFit:mediation];
        }
    }
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

// iOS7
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self.adView rotateToOrientation:toInterfaceOrientation];
}

- (void)setAdViewAutolayoutConstraint:(UIView *)target mine:(UIView *)_mine
{
    [target addSubview:_mine];
    
    [_mine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [target addConstraint:[NSLayoutConstraint
                           constraintWithItem:_mine
                           attribute:NSLayoutAttributeTop
                           relatedBy:NSLayoutRelationEqual
                           toItem:target
                           attribute:NSLayoutAttributeTop
                           multiplier:1
                           constant:0]];
    
    [target addConstraint:[NSLayoutConstraint
                           constraintWithItem:_mine
                           attribute:NSLayoutAttributeBottom
                           relatedBy:NSLayoutRelationEqual
                           toItem:target
                           attribute:NSLayoutAttributeBottom
                           multiplier:1
                           constant:0]];
    
    [target addConstraint:[NSLayoutConstraint
                           constraintWithItem:_mine
                           attribute:NSLayoutAttributeLeading
                           relatedBy:NSLayoutRelationEqual
                           toItem:target
                           attribute:NSLayoutAttributeLeading
                           multiplier:1
                           constant:0]];
    
    [target addConstraint:[NSLayoutConstraint
                           constraintWithItem:_mine
                           attribute:NSLayoutAttributeTrailing
                           relatedBy:NSLayoutRelationEqual
                           toItem:target
                           attribute:NSLayoutAttributeTrailing
                           multiplier:1
                           constant:0]];
    
    CGFloat _height = 0.0f;
    _height = 50.0f;
    
    [target addConstraint:[NSLayoutConstraint
                           constraintWithItem:_mine
                           attribute:NSLayoutAttributeHeight
                           relatedBy:NSLayoutRelationEqual
                           toItem:nil
                           attribute:NSLayoutAttributeNotAnAttribute
                           multiplier:1
                           constant:_height]];
    
    [_mine setNeedsUpdateConstraints];
}


- (void)loadExelBid:(EBMediation *)mediation
{
    self.adView = [[EBAdView alloc] initWithAdUnitId:mediation.unit_id size:_adViewContainer.bounds.size];
    self.adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.adView.delegate = self;
    [self.adView setYob:@"1976"];
    [self.adView setGender:@"M"];
    [self.adView setFullWebView:YES];
    [self.adView setTesting:YES];
    
    [_adViewContainer addSubview:self.adView];
    
    [self.adView loadAd];
}

- (void)loadAdFit:(EBMediation *)mediation
{
    self.bannerAdView = [[AdFitBannerAdView alloc] initWithClientId:mediation.unit_id adUnitSize:@"320x50"];
    self.bannerAdView.frame = CGRectMake(0.f, 0.f, _adViewContainer.bounds.size.width, _adViewContainer.bounds.size.height);
    self.bannerAdView.rootViewController = self;

    [_adViewContainer addSubview:self.bannerAdView];
    
    [self.bannerAdView loadAd];
}

#pragma mark - EBAdViewDelegate

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (void)adViewDidLoadAd:(EBAdView *)view
{
    _spinner.hidden = YES;
    NSLog(@"ExelBid - adViewDidLoadAd");
}

- (void)adViewDidFailToLoadAd:(EBAdView *)view
{
    _spinner.hidden = YES;
    NSLog(@"ExelBid - adViewDidFailToLoadAd");
}

- (void)willLoadViewForAd:(EBAdView *)view {
    NSLog(@"ExelBid - willLoadViewForAd");
}

- (void)didLoadViewForAd:(EBAdView *)view {
    NSLog(@"ExelBid - didLoadViewForAd");
}

- (void)willLeaveApplicationFromAd:(EBAdView *)view {
    NSLog(@"ExelBid - willLeaveApplicationFromAd");
}

#pragma mark - AdFitBannerAdViewDelegate

- (void)adViewDidReceiveAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"Adfit - didReceiveAd");
}

- (void)adViewDidFailToReceiveAd:(AdFitBannerAdView *)bannerAdView error:(NSError *)error {
    NSLog(@"Adfit - didFailToReceiveAd - error : %@", [error localizedDescription]);
}

- (void)adViewDidClickAd:(AdFitBannerAdView *)bannerAdView {
    NSLog(@"Adfit - didClickAd");
}


@end
