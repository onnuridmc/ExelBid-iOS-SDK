//
//  EBAdInfo.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBAdInfo.h"
#import <UIKit/UIKit.h>

@implementation EBAdInfo

+ (NSDictionary *)supportedAddedAdTypes
{
    static NSDictionary *adTypes = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        adTypes = @{@"Banner":@(EBAdInfoBanner), @"Native":@(EBAdInfoNative)};
    });
    
    return adTypes;
}

+ (NSArray *)bannerAds
{
    NSMutableArray *ads = [NSMutableArray array];
    
    [ads addObjectsFromArray:@[
                               [EBAdInfo infoWithTitle:@"배너광고" ID:@"d7865ee82b3a1a54f8beaddf817acb975098f312" type:EBAdInfoBanner],
                               [EBAdInfo infoWithTitle:@"전면광고" ID:@"196b7524e0682351c794650dcb35dc7a032c7fab" type:EBAdInfoAllBanner],
                               [EBAdInfo infoWithTitle:@"다이얼로그광고" ID:@"196b7524e0682351c794650dcb35dc7a032c7fab,e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoDailBanner],
                               ]];
    
    return ads;
}

+ (NSArray *)nativeAds
{
    return @[
             [EBAdInfo infoWithTitle:@"네이티브" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoNative],
             [EBAdInfo infoWithTitle:@"네이티브 Banner" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoNativeBanner],
             [EBAdInfo infoWithTitle:@"네이티브 Ad (CollectionView)" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoNativeInCollectionView],
             [EBAdInfo infoWithTitle:@"네이티브 Ad (TableView)" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoNativeTableViewPlacer],
             ];
}

+ (NSArray *)etcAds
{
    return @[
             [EBAdInfo infoWithTitle:@"미디에이션 Banner" ID:@"d7865ee82b3a1a54f8beaddf817acb975098f312" type:EBAdInfoMediationBanner],
             [EBAdInfo infoWithTitle:@"미디에이션 Native" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoMediationNative],
             [EBAdInfo infoWithTitle:@"미디에이션 BizboardView" ID:@"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d" type:EBAdInfoMediationBizboardView]
             ];
}

+ (EBAdInfo *)infoWithTitle:(NSString *)title ID:(NSString *)ID type:(EBAdInfoType)type
{
    EBAdInfo *info = [[EBAdInfo alloc] init];
    info.title = title;
    info.ID = ID;
    info.type = type;
    return info;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self != nil)
    {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        self.keywords = [aDecoder decodeObjectForKey:@"keywords"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:((self.keywords != nil) ? self.keywords : @"") forKey:@"keywords"];
}


@end
