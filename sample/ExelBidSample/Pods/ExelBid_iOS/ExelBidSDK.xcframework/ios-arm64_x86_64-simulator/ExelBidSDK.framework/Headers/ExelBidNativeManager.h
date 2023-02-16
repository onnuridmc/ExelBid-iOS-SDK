//
//  ExelBidNativeManager.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 21..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EBNativeAd;
@class EBNativeAdRequest;
@class EBNativeAdRequestTargeting;
@class CLLocation;

typedef void(^EBNativeAdRequestHandler)(EBNativeAdRequest *request,
EBNativeAd *response,
NSError *error);

////////////////////////////////////////////////////////////////////////////////////////////////////

@interface ExelBidNativeManager : NSObject

/**
 * A string representing a set of keywords that should be passed to the ExelBid ad server to receive
 * more relevant advertising.
 *
 * Keywords are typically used to target ad campaigns at specific user segments. They should be
 * formatted as comma-separated key-value pairs (e.g. "marital:single,age:24").
 *
 * On the ExelBid website, keyword targeting options can be found under the "Advanced Targeting"
 * section when managing campaigns.
 */
+ (void)keywords:(NSString *)keywords;

/**
 * A `CLLocation` object representing a user's location that should be passed to the ExelBid ad server
 * to receive more relevant advertising.
 */
+ (void)location:(CLLocation *)location;

/**
 * A set of defined strings that correspond to assets for the intended native ad
 * object. This set should contain only those assets that will be displayed in the ad.
 *
 * The ExelBid ad server will attempt to only return the assets in desiredAssets.
 */
+ (void)desiredAssets:(NSSet *)desiredAssets;

/**
 Year of birth (ex:2016)
 */

+ (void)yob:(NSString *)yob;

/**
 Gender (ex: M,F)
 */

+ (void)gender:(NSString *)gender;

/**
 * A Boolean value that determines whether the ad view should request ads in test mode.
 *
 * The default value is NO.
 * @warning **Important**: If you set this value to YES, make sure to reset it to NO before
 * submitting your application to the App Store.
 */
+ (void)testing:(BOOL)testing;

/**
 Coppa (default : 0)
 */

+ (void)coppa:(NSString *)coppa;



+ (void)initNativeAdWithAdUnitIdentifier:(NSString *)identifier adViewClass:(Class)adViewClass;

/**
 * Executes a request to the ExelBid ad server.
 *
 * @param handler A block to execute when the request finishes. The block includes as parameters the
 * request itself and either a valid EBNativeAd or an NSError object indicating failure.
 */
+ (void)startWithCompletionHandler:(EBNativeAdRequestHandler)handler;


@end
