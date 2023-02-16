//
//  EBAdInfo.h
//  ExelbidSample
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EBAdInfoType) {
    EBAdInfoBanner,
    EBAdInfoAllBanner,
    EBAdInfoDailBanner,
    EBAdInfoNative,
    EBAdInfoNativeBanner,
    EBAdInfoNativeTableViewPlacer,
    EBAdInfoNativeInCollectionView,
    EBAdInfoRewardedVideo,
    EBAdInfoMediationBanner,
    EBAdInfoMediationNative,
    EBAdInfoMediationBizboardView
};

@interface EBAdInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, assign) EBAdInfoType type;
@property (nonatomic, copy) NSString *keywords;

+ (NSArray *)bannerAds;
+ (NSArray *)nativeAds;
+ (NSArray *)etcAds;
+ (EBAdInfo *)infoWithTitle:(NSString *)title ID:(NSString *)ID type:(EBAdInfoType)type;
+ (NSDictionary *)supportedAddedAdTypes;

@end
