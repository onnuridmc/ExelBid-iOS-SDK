//
//  EBCollectionViewAdPlacerView.h
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 14..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ExelBidSDK/EBNativeAdRendering.h>

@interface EBCollectionViewAdPlacerView : UIView <EBNativeAdRendering>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *ctaLabel;
@property (strong, nonatomic) UIImageView *privacyInformationIconImageView;



@end
