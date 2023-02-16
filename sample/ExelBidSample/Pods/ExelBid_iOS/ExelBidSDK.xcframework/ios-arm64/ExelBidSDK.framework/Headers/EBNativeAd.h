//
//  EBNativeAd.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol EBNativeAdAdapter;
@protocol EBNativeAdDelegate;
@protocol EBNativeAdRenderer;
@class EBAdConfiguration;

/**
 * The `EBNativeAd` class is used to render and manage events for a native advertisement. The
 * class provides methods for accessing native ad properties returned by the server, as well as
 * convenience methods for URL navigation and metrics-gathering.
 */

@interface EBNativeAd : NSObject

/** @name Ad Resources */

/**
 * The delegate of the `EBNativeAd` object.
 */
@property (nonatomic, weak) id<EBNativeAdDelegate> delegate;

/**
 * A dictionary representing the native ad properties.
 */
@property (nonatomic, readonly) NSDictionary *properties;

- (instancetype)initWithAdAdapter:(id<EBNativeAdAdapter>)adAdapter;

/** @name Retrieving Ad View */

/**
 * Retrieves a rendered view containing the ad.
 *
 * @param error A pointer to an error object. If an error occurs, this pointer will be set to an
 * actual error object containing the error information.
 *
 * @return If successful, the method will return a view containing the rendered ad. The method will
 * return nil if it cannot render the ad data to a view.
 */
- (UIView *)retrieveAdViewWithError:(NSError **)error;

- (void)trackMetricForURL:(NSURL *)URL;

- (NSString *)getDspCampaignId;
- (NSString *)getDspCreativeId;
- (NSString *)getCampaignId;
- (NSString *)getCreativeId;

@end


@protocol EBNativeAdDelegate <NSObject>

@optional

/**
 * Sent when the native ad will present its modal content.
 *
 * @param nativeAd The native ad sending the message.
 */
- (void)willLoadForNativeAd:(EBNativeAd *)nativeAd;

/**
 * Sent when a native ad has dismissed its modal content, returning control to your application.
 *
 * @param nativeAd The native ad sending the message.
 */
- (void)didLoadForNativeAd:(EBNativeAd *)nativeAd;

/**
 * Sent when a user is about to leave your application as a result of tapping this native ad.
 *
 * @param nativeAd The native ad sending the message.
 */
- (void)willLeaveApplicationFromNativeAd:(EBNativeAd *)nativeAd;

@required

/** @name Managing Modal Content Presentation */

/**
 * Asks the delegate for a view controller to use for presenting modal content, such as the in-app
 * browser that can appear when an ad is tapped.
 *
 * @return A view controller that should be used for presenting modal content.
 */
- (UIViewController *)viewControllerForPresentingModalView;

@end

@protocol EBNativeAdOverrideDelegate

- (BOOL)overrideClickForNativeAd:(EBNativeAd *)nativeAd originalURL:(NSURL *)URL;

@end
