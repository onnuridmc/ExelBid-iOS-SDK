//
//  EBTableViewAdPlacerView.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 11..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBTableViewAdPlacerView.h"

@implementation EBTableViewAdPlacerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [self.titleLabel setText:@"Title"];
        [self addSubview:self.titleLabel];
        
        self.mainTextLabel = [[UILabel alloc] init];
        [self.mainTextLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.mainTextLabel setText:@"Text"];
        [self.mainTextLabel setNumberOfLines:2];
        [self addSubview:self.mainTextLabel];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        
        self.mainImageView = [[UIImageView alloc] init];
        [self.mainImageView setClipsToBounds:YES];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:self.mainImageView];
        
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
        self.mainTextLabel.textColor = [UIColor colorWithWhite:0.26 alpha:1.0f];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    
    self.titleLabel.frame = CGRectMake(75, 10, 212, 60);
    self.iconImageView.frame = CGRectMake(10, 10, 60, 60);
    self.privacyInformationIconImageView.frame = CGRectMake(width - 35, 10, 25, 25);
    self.ctaLabel.frame = CGRectMake(width - 100, 280, 90, 40);
    self.mainTextLabel.frame = CGRectMake(width / 2 - 150, 68, 300, 50);
    self.mainImageView.frame = CGRectMake(width / 2 - 150, 119, 300, 156);
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
