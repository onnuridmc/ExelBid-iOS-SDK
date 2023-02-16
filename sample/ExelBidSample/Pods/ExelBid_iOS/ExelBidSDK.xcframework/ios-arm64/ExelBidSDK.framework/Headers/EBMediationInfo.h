//
//  EBMediationInfo.h
//
//  Created by Jaeuk Jeong on 2023/02/09.
//

#import <Foundation/Foundation.h>
#import "EBMediation.h"

static NSString * const EBMediationTypeExelbid = @"exelbid";
static NSString * const EBMediationTypeAdfit = @"adfit";
static NSString * const EBMediationTypeAdmob = @"admob";
static NSString * const EBMediationTypeFan = @"fan";
static NSString * const EBMediationTypeNot = @"not";

@interface EBMediationInfo : NSObject

- (id)initWithData:(NSArray *)mediations;
- (NSUInteger)size;
- (EBMediation *)next;
- (void)reset;

@end
