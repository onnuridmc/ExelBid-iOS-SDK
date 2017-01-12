//
//  EBAdSection.h
//  ExelbidSample
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EBAdInfo;

@interface EBAdSection : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign, readonly) NSUInteger count;

+ (NSArray *)adSections;
+ (EBAdSection *)sectionWithTitle:(NSString *)title ads:(NSArray *)ads;

- (EBAdInfo *)adAtIndex:(NSUInteger)index;

@end
