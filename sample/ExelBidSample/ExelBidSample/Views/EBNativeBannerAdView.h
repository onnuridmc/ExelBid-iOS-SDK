//
//  EBNativeBannerAdView.h
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 10..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExelBidSDK/ExelBidSDK.h>

@interface EBNativeBannerAdView : UIView<EBNativeAdRendering>
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *mainTextLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *ctaLabel;
@property (strong, nonatomic) UIImageView *privacyInformationIconImageView;

@property (strong, nonatomic) NSTimer *adTimer;
@end
