//
//  EBConfig.m
//  ExelBid
//
//  Created by HeroK on 2016. 12. 7..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBConfig.h"

#define uBannerUnitIdKey            @"uBannerUnitIdKey"
#define uFrontBannerUnitIdKey       @"uFrontBannerUnitIdKey"
#define uNativeUnitIdKey            @"uNativeUnitIdKey"

#define kBannerUnitId               @"d7865ee82b3a1a54f8beaddf817acb975098f312"     //홈페이지에서 발급받은 띠배너 유닛 아이디
#define kFrontBannerUnitId          @"196b7524e0682351c794650dcb35dc7a032c7fab"     //홈페이지에서 발급받은 전면 배너 유닛 아이디
#define kNativeUnitId               @"e7ae59cf167c7b6c0fd3f71f329a22826ddb6b0d"     //홈페이지에서 발급받은 네이티브 배너 유닛 아이디

@implementation EBConfig

+ (void)setBannerUnitId:(NSString *)unitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:unitId forKey:uBannerUnitIdKey];
    [udf synchronize];
}

+ (NSString *)getBannerUnitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    return [udf objectForKey:uBannerUnitIdKey] ?  [udf objectForKey:uBannerUnitIdKey] : kBannerUnitId;
}

+ (void)setFrontBannerUnitId:(NSString *)unitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:unitId forKey:uFrontBannerUnitIdKey];
    [udf synchronize];
}

+ (NSString *)getFrontBannerUnitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    return [udf objectForKey:uFrontBannerUnitIdKey] ?  [udf objectForKey:uFrontBannerUnitIdKey] : kFrontBannerUnitId;
}

+ (void)setNativeUnitId:(NSString *)unitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    [udf setObject:unitId forKey:uNativeUnitIdKey];
    [udf synchronize];
}

+ (NSString *)getNativeUnitId {
    NSUserDefaults *udf = [NSUserDefaults standardUserDefaults];
    return [udf objectForKey:uNativeUnitIdKey] ?  [udf objectForKey:uNativeUnitIdKey] : kNativeUnitId;
}

@end
