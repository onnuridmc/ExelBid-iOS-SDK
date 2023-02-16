//
//  EBCollectionViewAdPlacerView.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 14..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBCollectionViewAdPlacerView.h"

@implementation EBCollectionViewAdPlacerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 0, 61, 24)];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
        [self.titleLabel setText:@"Title"];
        [self addSubview:self.titleLabel];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 30, 60, 60)];
        [self.iconImageView setClipsToBounds:YES];
        [self.iconImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.iconImageView];
        
        self.privacyInformationIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(56, 5, 12, 12)];
        [self addSubview:self.privacyInformationIconImageView];
        
        self.ctaLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 94, 66, 15)];
        [self.ctaLabel setBackgroundColor:[UIColor colorWithWhite:0.20 alpha:1.0f]];
        [self.ctaLabel setFont:[UIFont systemFontOfSize:10.0f]];
        [self.ctaLabel setText:@"CTA Text"];
        [self.ctaLabel setTextColor:[UIColor colorWithWhite:0.91 alpha:1.0f]];
        [self.ctaLabel setTextAlignment:NSTextAlignmentCenter];
        [self.ctaLabel setClipsToBounds:YES];
        [self.ctaLabel.layer setCornerRadius:5.0f];
        [self addSubview:self.ctaLabel];
        
        self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0f];
        self.titleLabel.textColor = [UIColor colorWithWhite:0.26 alpha:1.0f];
    }
    return self;
}

#pragma mark - <MPNativeAdRendering>

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
