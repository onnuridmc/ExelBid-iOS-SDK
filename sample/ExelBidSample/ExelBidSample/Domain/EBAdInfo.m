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
                               [EBAdInfo infoWithTitle:@"배너광고" ID:[EBConfig getBannerUnitId] type:EBAdInfoBanner],
                               [EBAdInfo infoWithTitle:@"전면광고" ID:[EBConfig getFrontBannerUnitId] type:EBAdInfoAllBanner],
                               [EBAdInfo infoWithTitle:@"다이얼로그광고" ID:[NSString stringWithFormat:@"%@,%@",[EBConfig getFrontBannerUnitId],[EBConfig getNativeUnitId]] type:EBAdInfoDailBanner],
                               ]];
    
    return ads;
}

+ (NSArray *)nativeAds
{
    return @[
             [EBAdInfo infoWithTitle:@"네이티브" ID:[EBConfig getNativeUnitId] type:EBAdInfoNative],
             [EBAdInfo infoWithTitle:@"네이티브 Banner" ID:[EBConfig getNativeUnitId] type:EBAdInfoNativeBanner],
             [EBAdInfo infoWithTitle:@"네이티브 Ad (CollectionView)" ID:[EBConfig getNativeUnitId] type:EBAdInfoNativeInCollectionView],
             [EBAdInfo infoWithTitle:@"네이티브 Ad (TableView)" ID:[EBConfig getNativeUnitId] type:EBAdInfoNativeTableViewPlacer],
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
