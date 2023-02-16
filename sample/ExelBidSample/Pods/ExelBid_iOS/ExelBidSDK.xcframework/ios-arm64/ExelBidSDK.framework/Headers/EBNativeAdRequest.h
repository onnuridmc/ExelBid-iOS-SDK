//
//  EBNativeAdRequest.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EBNativeAd;
@class EBNativeAdRequest;
@class EBNativeAdRequestTargeting;

typedef void(^EBNativeAdRequestHandler)(EBNativeAdRequest *request,
                                        EBNativeAd *response,
                                        NSError *error);

////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * The `EBNativeAdRequest` class is used to manage individual requests to the ExelBid ad server for
 * native ads.
 *
 * @warning **Note:** This class is meant for one-off requests for which you intend to manually
 * process the native ad response. If you are using `EBTableViewAdPlacer` or
 * `EBCollectionViewAdPlacer` to display ads, there should be no need for you to use this class.
 */

@interface EBNativeAdRequest : NSObject

/** @name Targeting Information */

/**
 * An object representing targeting parameters that can be passed to the ExelBid ad server to
 * serve more relevant advertising.
 */
@property (nonatomic, strong) EBNativeAdRequestTargeting *targeting;

/** @name Initializing and Starting an Ad Request */

/**
 * Initializes a request object.
 *
 * @param identifier The ad unit identifier for this request. An ad unit is a defined placement in
 * your application set aside for advertising. Ad unit IDs are created on the ExelBid website.
 *
 * @param rendererConfigurations An array of EBNativeAdRendererConfiguration objects that control how
 * the native ad is rendered.
 *
 * @return An `EBNativeAdRequest` object.
 */
+ (EBNativeAdRequest *)requestWithAdUnitIdentifier:(NSString *)identifier rendererConfigurations:(NSArray *)rendererConfigurations;

/**
 * Executes a request to the ExelBid ad server.
 *
 * @param handler A block to execute when the request finishes. The block includes as parameters the
 * request itself and either a valid EBNativeAd or an NSError object indicating failure.
 */
- (void)startWithCompletionHandler:(EBNativeAdRequestHandler)handler;


@end
