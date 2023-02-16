//
//  EBNativeAdRequestTargeting.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

/**
 * The `EBNativeAdRequestTargeting` class is used to attach targeting information to
 * `EBNativeAdRequest` objects.
 */

@interface EBNativeAdRequestTargeting : NSObject

/** @name Creating a Targeting Object */

/**
 * Creates and returns an empty EBNativeAdRequestTargeting object.
 *
 * @return A newly initialized EBNativeAdRequestTargeting object.
 */
+ (EBNativeAdRequestTargeting *)targeting;

/** @name Targeting Parameters */

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
@property (nonatomic, copy) NSString *keywords;

/**
 * A `CLLocation` object representing a user's location that should be passed to the ExelBid ad server
 * to receive more relevant advertising.
 */
@property (nonatomic, copy) CLLocation *location;

/**
 * A set of defined strings that correspond to assets for the intended native ad
 * object. This set should contain only those assets that will be displayed in the ad.
 *
 * The ExelBid ad server will attempt to only return the assets in desiredAssets.
 */
@property (nonatomic, strong) NSSet *desiredAssets;

/**
 Year of birth (ex:2016)
 */

@property (nonatomic, copy) NSString *yob;

/**
 Gender (ex: M,F)
 */

@property (nonatomic, copy) NSString *gender;

/**
 * A Boolean value that determines whether the ad view should request ads in test mode.
 *
 * The default value is NO.
 * @warning **Important**: If you set this value to YES, make sure to reset it to NO before
 * submitting your application to the App Store.
 */
@property (nonatomic, assign, getter = isTesting) BOOL testing;

/**
 Coppa (default : 0)
 */

@property (nonatomic, copy) NSString *coppa;



@end
