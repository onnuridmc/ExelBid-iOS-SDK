//
//  EBNativeBannerAdView.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 10..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeBannerAdView.h"

@implementation EBNativeBannerAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [self.titleLabel setText:@"Title"];
        [self addSubview:self.titleLabel];
        
        self.mainTextLabel = [[UILabel alloc] init];
        [self.mainTextLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.mainTextLabel setText:@"Text"];
        [self.mainTextLabel setNumberOfLines:2];
        [self addSubview:self.mainTextLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.ctaLabel = [[UILabel alloc] init];
        [self.ctaLabel setBackgroundColor:[UIColor colorWithWhite:0.20 alpha:1.0f]];
        [self.ctaLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [self.ctaLabel setText:@"CTA Text"];
        [self.ctaLabel setTextAlignment:NSTextAlignmentCenter];
        self.ctaLabel.clipsToBounds = YES;
        [self addSubview:self.ctaLabel];
        
        self.privacyInformationIconImageView = [[UIImageView alloc] init];
        [self addSubview:self.privacyInformationIconImageView];
        
        self.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.0f];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.26 alpha:1.0f];
        self.mainTextLabel.textColor = [UIColor colorWithWhite:0.26 alpha:1.0f];
        self.ctaLabel.textColor = [UIColor colorWithWhite:0.91 alpha:1.0f];
        
        self.clipsToBounds = YES;
        [self performSelector:@selector(adAnimation1) withObject:nil afterDelay:2.0f];
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    
    self.titleLabel.frame = CGRectMake(70, 0, width - 170, 50);
    self.iconImageView.frame = CGRectMake(20, 10, 30, 30);
    self.ctaLabel.frame = CGRectMake(width - 60, 10, 50, 30);
    self.mainTextLabel.frame = CGRectMake(70, 50, width - 170, 50);
    self.privacyInformationIconImageView.frame = CGRectMake(width - 90, 15, 20, 20);
    [self.ctaLabel.layer setCornerRadius:3.0f];
   
}

- (void)adAnimation1 {
    CGFloat width = self.bounds.size.width;
    [UIView animateWithDuration:1.0f
                     animations:^{
                         self.titleLabel.frame = CGRectMake(70, -50, width - 170, 50);
                         self.mainTextLabel.frame = CGRectMake(70, 0, width - 170, 50);
                         
                     } completion:^(BOOL finished) {
                         self.titleLabel.frame = CGRectMake(70, 50, width - 170, 50);
                         [self performSelector:@selector(adAnimation2) withObject:nil afterDelay:2.0f];
                     }];
}

- (void)adAnimation2 {
    CGFloat width = self.bounds.size.width;
    [UIView animateWithDuration:1.0f
                     animations:^{
                         self.titleLabel.frame = CGRectMake(70, 0, width - 170, 50);
                         self.mainTextLabel.frame = CGRectMake(70, -50, width - 170, 50);
                         
                     } completion:^(BOOL finished) {
                         self.mainTextLabel.frame = CGRectMake(70, 50, 200, 50);
                         [self performSelector:@selector(adAnimation1) withObject:nil afterDelay:2.0f];
                     }];
}

#pragma mark - <MPNativeAdRendering>

- (UILabel *)nativeMainTextLabel
{
    return self.mainTextLabel;
}

- (UILabel *)nativeTitleTextLabel
{
    return self.titleLabel;
}

- (UILabel *)nativeCallToActionTextLabel
{
    return self.ctaLabel;
}

- (UIImageView *)nativeIconImageView
{
    return self.iconImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.privacyInformationIconImageView;
}

@end
