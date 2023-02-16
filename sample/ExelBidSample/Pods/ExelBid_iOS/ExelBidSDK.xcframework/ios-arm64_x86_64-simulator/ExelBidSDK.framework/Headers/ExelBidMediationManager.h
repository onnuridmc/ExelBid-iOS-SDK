//
//  ExelBidMediationManager.h
//
//  Created by Jaeuk Jeong on 2023/02/06.
//

#import <Foundation/Foundation.h>

@class EBMediationInfo;
@class EBMediationRequest;
@class CLLocation;

typedef void(^EBMediationRequestHandler)(EBMediationRequest *request,
                                         EBMediationInfo *response,
                                         NSError *error);

@interface ExelBidMediationManager : NSObject

+ (void)testing:(BOOL)testing;

+ (void)mediationTypes:(NSSet *)mediationTypes;

+ (void)initMediationWithAdUnitIdentifier:(NSString *)identifier;

+ (void)startWithCompletionHandler:(EBMediationRequestHandler)handler;

@end
