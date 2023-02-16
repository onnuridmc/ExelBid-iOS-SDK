//
//  ExelBid.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 10. 27..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

// Import these frameworks for module support.
#import <AdSupport/AdSupport.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import <QuartzCore/QuartzCore.h>
#import <StoreKit/StoreKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>

#define ExelBidKit [ExelBid sharedInstance]

@interface ExelBid : NSObject

/**
 * 홈페이지에 등록한 어플리케이션의 아이디
 */
@property (nonatomic, strong) NSString *EBAppId;


/**
 * Returns the ExelBid singleton object.
 *
 * @return The ExelBid singleton object.
 */
+ (ExelBid *)sharedInstance;

/**
 * A Boolean value indicating whether the ExelBid SDK should use Core Location APIs to automatically
 * derive targeting information for location-based ads.
 *
 * When set to NO, the SDK will not attempt to determine device location. When set to YES, the
 * SDK will periodically try to listen for location updates in order to request location-based ads.
 * This only occurs if location services are enabled and the user has already authorized the use
 * of location services for the application. The default value is YES.
 *
 * @param enabled A Boolean value indicating whether the SDK should listen for location updates.
 */
@property (nonatomic, assign) BOOL locationUpdatesEnabled;


/**
 * A Boolean value indicating whether the ExelBid SDK should create a ExelBid ID that can be used
 * for frequency capping when Limit ad tracking is on & the IDFA we get is
 * 00000000-0000-0000-0000-000000000000.
 *
 * When set to NO, the SDK will not create a ExelBid ID in the above case. When set to YES, the
 * SDK will generate a ExelBid ID. The default value is YES.
 *
 */
@property (nonatomic) BOOL frequencyCappingIdUsageEnabled;
//
///** @name Rewarded Video */
///**
// * Initializes the rewarded video system.
// *
// * This method should only be called once. It should also be called prior to requesting any rewarded video ads.
// * Once the global mediation settings and delegate are set, they cannot be changed.
// *
// * @param globalMediationSettings Global configurations for all rewarded video ad networks your app supports.
// *
// * @param delegate The delegate that will receive all events related to rewarded video.
// */
//- (void)initializeRewardedVideoWithGlobalMediationSettings:(NSArray *)globalMediationSettings delegate:(id<MPRewardedVideoDelegate>)delegate;
//
///**
// * Retrieves the global mediation settings for a given class type.
// *
// * @param aClass The type of mediation settings object you want to receive from the collection.
// */
//- (id<MPMediationSettingsProtocol>)globalMediationSettingsForClass:(Class)aClass;

- (NSString *)version;

@end
