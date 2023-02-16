//
//  EBMediationNativeAdViewController.m
//
//  Created by Jaeuk Jeong on 2023/02/09.
//

#import "EBMediationNativeAdViewController.h"
#import "EBNativeAdView.h"
#import <ExelBidSDK/ExelBidSDK.h>
#import "EBAdFitNativeAdView.h"

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdFitSDK/AdFitSDK.h>

@interface EBMediationNativeAdViewController ()<UITextFieldDelegate, EBNativeAdDelegate, AdFitNativeAdDelegate, AdFitNativeAdLoaderDelegate>

@property (weak, nonatomic) IBOutlet UITextField *keywordsTextField;
@property (weak, nonatomic) IBOutlet UIButton *loadAdButton;
@property (weak, nonatomic) IBOutlet UIButton *showAdButton;

@property (nonatomic, strong) EBMediationInfo *mediationInfo;
@property (nonatomic, strong) EBNativeAd *nativeAd;
@property (nonatomic, strong) AdFitNativeAd *afNativeAd;
@property (nonatomic, strong) AdFitNativeAdLoader *afLoader;

@end

@implementation EBMediationNativeAdViewController

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
    [ExelBidMediationManager mediationTypes: [NSSet setWithObjects:@"exelbid", @"adfit", nil]];
    
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

- (void)loadExelBid:(EBMediation *)mediation
{
    [ExelBidNativeManager initNativeAdWithAdUnitIdentifier:mediation.unit_id adViewClass:[EBNativeAdView class]];
    [ExelBidNativeManager testing:YES];
    [ExelBidNativeManager yob:@"1976"];
    [ExelBidNativeManager gender:@"M"];
    [ExelBidNativeManager startWithCompletionHandler:^(EBNativeAdRequest *request, EBNativeAd *response, NSError *error) {
        if (error) {
            NSLog(@"================> %@", error);
            self.loadAdButton.enabled = YES;
            self.failLabel.hidden = NO;
        } else {
            NSLog(@"Received Native Ad");
            self.loadAdButton.enabled = YES;
            
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            
            UIView *adView = [self.nativeAd retrieveAdViewWithError:nil];
            [self.adViewContainer addSubview:adView];
            adView.frame = self.adViewContainer.bounds;
        }
        
        [self.spinner setHidden:YES];
    }];
}

- (void)loadAdFit:(EBMediation *)mediation
{
    self.afLoader = [[AdFitNativeAdLoader alloc] initWithClientId:mediation.unit_id count:1];
    self.afLoader.delegate = self;
    self.afLoader.infoIconPosition = AdFitInfoIconPositionTopRight;
    
    [self.afLoader loadAdWithKeyword:nil];
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
    NSLog(@"ExelBid - Will Load for native ad.");
}

- (void)didLoadForNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"ExelBid - Did Load for native ad.");
}

- (void)willLeaveApplicationFromNativeAd:(EBNativeAd *)nativeAd
{
    NSLog(@"ExelBid - Will leave application from native ad.");
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

#pragma mark - AdFitNativeAdDelegate

- (void)nativeAdLoaderDidReceiveAd:(AdFitNativeAd *)nativeAd
{
    NSLog(@"Adfit - nativeAdLoaderDidReceiveAd");
    
    self.afNativeAd = nativeAd;
    
    EBAdFitNativeAdView *nativeAdView = [[[NSBundle mainBundle] loadNibNamed:@"EBAdFitNativeAdView" owner:self options:nil] firstObject];
    
//    EBAdFitNativeAdView *nativeAdView = [[EBAdFitNativeAdView alloc] initWithFrame:CGRectMake(0.f, 0.f, 300.f, 200.f)];
    [nativeAd bind:nativeAdView];
    [self.adViewContainer addSubview:nativeAdView];
    
//    UINib *nib = [UINib nibWithNibName:@"EBAdFitNativeAdView" bundle:nil];
//
//    if (nib == nil) {
//        NSLog(@"nativeAdLoaderDidReceiveAd - load view");
//
//    } else {
//        NSLog(@"nativeAdLoaderDidReceiveAd - load nib");
//        EBAdFitNativeAdView *nativeAdView = [[nib instantiateWithOwner:nil options:nil] firstObject];
//        [nativeAd bind:nativeAdView];
//        [self.adViewContainer addSubview:nativeAdView];
//    }
}

- (void)nativeAdLoaderDidReceiveAds:(NSArray<AdFitNativeAd *> *)nativeAds
{
    NSLog(@"Adfit - nativeAdLoaderDidReceiveAds");
}

- (void)nativeAdLoaderDidFailToReceiveAd:(AdFitNativeAdLoader *)nativeAdLoader error:(NSError *)error
{
    NSLog(@"Adfit - nativeAdLoaderDidFailToReceiveAd - error : %@", error.localizedDescription);
}

@end

