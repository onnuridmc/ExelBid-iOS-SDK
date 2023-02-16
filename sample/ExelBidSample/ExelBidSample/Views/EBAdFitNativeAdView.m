//
//  EBAdFitNativeAdView.m
//
//  Created by Jaeuk Jeong on 2023/02/14.
//

#import "EBAdFitNativeAdView.h"

#import <AdFitSDK/AdFitSDK.h>

@interface EBAdFitNativeAdView () <AdFitNativeAdRenderable>

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyLabel;
@property (nonatomic, weak) IBOutlet UIButton *callToActionButton;
@property (nonatomic, weak) IBOutlet UILabel *profileNameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *profileIconView;
@property (nonatomic, weak) IBOutlet AdFitMediaView *mediaView;

@end

@implementation EBAdFitNativeAdView

#pragma mark - AdFitNativeAdRenderable
- (UILabel *)adTitleLabel {
    return self.titleLabel;
}

- (UILabel *)adBodyLabel {
    return self.bodyLabel;
}

- (UIButton *)adCallToActionButton {
    return self.callToActionButton;
}

- (UILabel *)adProfileNameLabel {
    return self.profileNameLabel;
}

- (UIImageView *)adProfileIconView {
    return self.profileIconView;
}

- (AdFitMediaView *)adMediaView {
    return self.mediaView;
}


@end
