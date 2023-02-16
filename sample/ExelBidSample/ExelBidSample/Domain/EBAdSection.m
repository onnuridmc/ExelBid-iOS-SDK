//
//  EBAdSection.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBAdSection.h"
#import "EBAdInfo.h"

@interface EBAdSection ()

@property (nonatomic, strong) NSArray *ads;

@end


@implementation EBAdSection

+ (NSArray *)adSections
{
    return @[
             [EBAdSection sectionWithTitle:@"Banner Ads" ads:[EBAdInfo bannerAds]],
             [EBAdSection sectionWithTitle:@"Native Ads" ads:[EBAdInfo nativeAds]],
             [EBAdSection sectionWithTitle:@"ETC Ads" ads:[EBAdInfo etcAds]],
             ];
}

+ (EBAdSection *)sectionWithTitle:(NSString *)title ads:(NSArray *)ads
{
    EBAdSection *section = [[EBAdSection alloc] init];
    section.title = title;
    section.ads = ads;
    return section;
}

- (EBAdInfo *)adAtIndex:(NSUInteger)index
{
    return [self.ads objectAtIndex:index];
}

- (NSUInteger)count
{
    return [self.ads count];
}

@end
