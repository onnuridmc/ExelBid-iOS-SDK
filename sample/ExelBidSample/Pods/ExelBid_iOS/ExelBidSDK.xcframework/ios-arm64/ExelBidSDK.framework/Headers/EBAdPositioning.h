//
//  EBAdPositioning.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 11..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EBAdPositioning : NSObject <NSCopying>

@property (nonatomic, assign) NSUInteger repeatingInterval;
@property (nonatomic, strong, readonly) NSMutableOrderedSet *fixedPositions;


@end
