//
//  EBConfig.h
//  ExelBid
//
//  Created by HeroK on 2016. 12. 7..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBConfig : NSObject

+ (void)setBannerUnitId:(NSString *)unitId;

+ (NSString *)getBannerUnitId;

+ (void)setFrontBannerUnitId:(NSString *)unitId;

+ (NSString *)getFrontBannerUnitId;

+ (void)setNativeUnitId:(NSString *)unitId;

+ (NSString *)getNativeUnitId;

@end
