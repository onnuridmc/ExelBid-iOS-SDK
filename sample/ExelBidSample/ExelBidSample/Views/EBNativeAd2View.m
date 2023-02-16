//
//  EBNativeAd2View.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 16..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeAd2View.h"

@implementation EBNativeAd2View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
        [self.titleLabel setText:@"Title"];
        [self addSubview:self.titleLabel];
        
        self.mainTextLabel = [[UILabel alloc] init];
        [self.mainTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.mainTextLabel setText:@"Text"];
        [self.mainTextLabel setNumberOfLines:2];
        [self addSubview:self.mainTextLabel];
        
        
        self.mainImageView = [[UIImageView alloc] init];
        [self.mainImageView setClipsToBounds:YES];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.mainImageView];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.ctaLabel = [[UILabel alloc] init];
        [self.ctaLabel setBackgroundColor:[UIColor colorWithWhite:0.20 alpha:1.0f]];
        [self.ctaLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.ctaLabel setText:@"CTA Text"];
        [self.ctaLabel setTextColor:[UIColor colorWithWhite:0.91 alpha:1.0f]];
        [self.ctaLabel setTextAlignment:NSTextAlignmentCenter];
        self.ctaLabel.clipsToBounds = YES;
        [self addSubview:self.ctaLabel];
        
        self.privacyInformationIconImageView = [[UIImageView alloc] init];
        [self addSubview:self.privacyInformationIconImageView];
        
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.26 alpha:1.0f];
        self.mainTextLabel.textColor = [UIColor colorWithWhite:0.46 alpha:1.0f];
        
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    
    self.mainImageView.frame = CGRectMake(0, 0, width, 190);
    self.iconImageView.frame = CGRectMake(20, 155, 60, 60);
    self.titleLabel.frame = CGRectMake(20, 210, 250, 30);
    self.mainTextLabel.frame = CGRectMake(20, 240, 300, 30);
    self.ctaLabel.frame = CGRectMake(20, 280, width - 40, 40);
    self.privacyInformationIconImageView.frame = CGRectMake(width - 35, 210, 25, 25);
    
    [self.ctaLabel.layer setCornerRadius:5.0f];
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

- (UIImageView *)nativeMainImageView
{
    return self.mainImageView;
}

- (UIImageView *)nativePrivacyInformationIconImageView
{
    return self.privacyInformationIconImageView;
}


@end
