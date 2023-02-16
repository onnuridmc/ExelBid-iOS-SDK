//
//  EBAdView.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 10. 24..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

typedef enum
{
    EBNativeAdOrientationAny,
    EBNativeAdOrientationPortrait,
    EBNativeAdOrientationLandscape
} EBNativeAdOrientation;

@protocol EBAdViewDelegate;

/**
 * The EBAdView class provides a view that can display banner advertisements.
 */

@interface EBAdView : UIView

/** @name Initializing a Banner Ad */

/**
 * Initializes an EBAdView with the given ad unit ID and banner size.
 *
 * @param adUnitId A string representing a ExelBid ad unit ID.
 * @param size The desired ad size. A list of standard ad sizes is available in EBConstants.h.
 * @return A newly initialized ad view corresponding to the given ad unit ID and size.
 */
- (id)initWithAdUnitId:(NSString *)adUnitId size:(CGSize)size;

/** @name Setting and Getting the Delegate */

/**
 * The delegate (`EBAdViewDelegate`) of the ad view.
 *
 * @warning **Important**: Before releasing an instance of `EBAdView`, you must set its delegate
 * property to `nil`.
 */
@property (nonatomic, weak) id<EBAdViewDelegate> delegate;

/** @name Setting Request Parameters */

/**
 * The ExelBid ad unit ID for this ad view.
 *
 * Ad unit IDs are created on the ExelBid website. An ad unit is a defined placement in your
 * application set aside for advertising. If no ad unit ID is set, the ad view will use a default
 * ID that only receives test ads.
 */
@property (nonatomic, copy) NSString *adUnitId;

/**
 Year of birth (ex:2016)
 */

@property (nonatomic, copy) NSString *yob;

/**
 Gender (ex: M,F)
 */

@property (nonatomic, copy) NSString *gender;

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

/** @name Enabling Test Mode */

/**
 * A Boolean value that determines whether the ad view should request ads in test mode.
 *
 * The default value is NO.
 * @warning **Important**: If you set this value to YES, make sure to reset it to NO before
 * submitting your application to the App Store.
 */
@property (nonatomic, assign, getter = isTesting) BOOL testing;

/** @name Loading a Banner Ad */

/**
 Coppa (default : 0)
 */

@property (nonatomic, copy) NSString *coppa;


/**
 FullSizeWebView (default : NO)
 */

@property (nonatomic, assign, getter = isFullWebView) BOOL fullWebView;


/**
 * Requests a new ad from the ExelBid ad server.
 *
 * If the ad view is already loading an ad, this call will be ignored. You may use `forceRefreshAd`
 * if you would like cancel any existing ad requests and force a new ad to load.
 */
- (void)loadAd;

/**
 * Cancels any existing ad requests and requests a new ad from the ExelBid ad server.
 */
- (void)forceRefreshAd;

/** @name Handling Orientation Changes */

/**
 * Informs the ad view that the device orientation has changed.
 *
 * Banners from some third-party ad networks have orientation-specific behavior. You should call
 * this method when your application's orientation changes if you want mediated ads to acknowledge
 * their new orientation.
 *
 * If your application layout needs to change based on the size of the mediated ad, you may want to
 * check the value of `adContentViewSize` after calling this method, in case the orientation change
 * causes the mediated ad to resize.
 *
 * @param newOrientation The new interface orientation (after orientation changes have occurred).
 */
- (void)rotateToOrientation:(UIInterfaceOrientation)newOrientation;

/**
 * Forces third-party native ad networks to only use ads sized for the specified orientation.
 *
 * Banners from some third-party ad networks have orientation-specific behaviors and/or sizes.
 * You may use this method to lock ads to a certain orientation. For instance,
 * if you call this with EBInterfaceOrientationPortrait, native networks will never
 * return ads sized for the landscape orientation.
 *
 * @param orientation An EBNativeAdOrientation enum value.
 *
 * <pre><code>typedef enum {
 *          EBNativeAdOrientationAny,
 *          EBNativeAdOrientationPortrait,
 *          EBNativeAdOrientationLandscape
 *      } EBNativeAdOrientation;
 * </pre></code>
 *
 * @see unlockNativeAdsOrientation
 * @see allowedNativeAdsOrientation
 */

- (void)lockNativeAdsToOrientation:(EBNativeAdOrientation)orientation;

/**
 * Allows third-party native ad networks to use ads sized for any orientation.
 *
 * You do not need to call this method unless you have previously called
 * `lockNativeAdsToOrientation:`.
 *
 * @see lockNativeAdsToOrientation:
 * @see allowedNativeAdsOrientation
 */
- (void)unlockNativeAdsOrientation;

/**
 * Returns the banner orientations that third-party ad networks are allowed to use.
 *
 * @return An enum value representing an allowed set of orientations.
 *
 * @see lockNativeAdsToOrientation:
 * @see unlockNativeAdsOrientation
 */
- (EBNativeAdOrientation)allowedNativeAdsOrientation;

/** @name Obtaining the Size of the Current Ad */

/**
 * Returns the size of the current ad being displayed in the ad view.
 *
 * Ad sizes may vary between different ad networks. This method returns the actual size of the
 * underlying mediated ad. This size may be different from the original, initialized size of the
 * ad view. You may use this size to determine to adjust the size or positioning of the ad view
 * to avoid clipping or border issues.
 *
 * @returns The size of the underlying mediated ad.
 */
- (CGSize)adContentViewSize;

/** @name Managing the Automatic Refreshing of Ads */

/**
 * Stops the ad view from periodically loading new advertisements.
 *
 * By default, an ad view is allowed to automatically load new advertisements if a refresh interval
 * has been configured on the ExelBid website. This method prevents new ads from automatically loading,
 * even if a refresh interval has been specified.
 *
 * As a best practice, you should call this method whenever the ad view will be hidden from the user
 * for any period of time, in order to avoid unnecessary ad requests. You can then call
 * `startAutomaticallyRefreshingContents` to re-enable the refresh behavior when the ad view becomes
 * visible.
 *
 * @see startAutomaticallyRefreshingContents
 */
- (void)stopAutomaticallyRefreshingContents;

/**
 * Causes the ad view to periodically load new advertisements in accordance with user-defined
 * refresh settings on the ExelBid website.
 *
 * Calling this method is only necessary if you have previously stopped the ad view's refresh
 * behavior using `stopAutomaticallyRefreshingContents`. By default, an ad view is allowed to
 * automatically load new advertisements if a refresh interval has been configured on the ExelBid
 * website. This method has no effect if a refresh interval has not been set.
 *
 * @see stopAutomaticallyRefreshingContents
 */
- (void)startAutomaticallyRefreshingContents;

- (NSString *)getDspCampaignId;
- (NSString *)getDspCreativeId;
- (NSString *)getCampaignId;
- (NSString *)getCreativeId;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -

/**
 * The delegate of an `EBAdView` object must adopt the `EBAdViewDelegate` protocol. It must
 * implement `viewControllerForPresentingModalView` to provide a root view controller from which
 * the ad view should Load content.
 *
 * Optional methods of this protocol allow the delegate to be notified of banner success or
 * failure, as well as other lifecycle events.
 */

@protocol EBAdViewDelegate <NSObject>

@required

/** @name Managing Modal Content Presentation */

/**
 * Asks the delegate for a view controller to use for presenting modal content, such as the in-app
 * browser that can appear when an ad is tapped.
 *
 * @return A view controller that should be used for presenting modal content.
 */
- (UIViewController *)viewControllerForPresentingModalView;

@optional

/** @name Detecting When a Banner Ad is Loaded */

/**
 * Sent when an ad view successfully loads an ad.
 *
 * Your implementation of this method should insert the ad view into the view hierarchy, if you
 * have not already done so.
 *
 * @param view The ad view sending the message.
 */
- (void)adViewDidLoadAd:(EBAdView *)view;

/**
 * Sent when an ad view fails to load an ad.
 *
 * To avoid displaying blank ads, you should hide the ad view in response to this message.
 *
 * @param view The ad view sending the message.
 */
- (void)adViewDidFailToLoadAd:(EBAdView *)view statusCode:(NSInteger)statusCode;

/** @name Detecting When a User Interacts With the Ad View */

/**
 * Sent when an ad view is about to Load content.
 *
 * This method is called when the user taps on the ad view. Your implementation of this method
 * should pause any application activity that requires user interaction.
 *
 * @param view The ad view sending the message.
 * @see `didLoadViewForAd:`
 */
- (void)willLoadViewForAd:(EBAdView *)view;

/**
 * Sent when an ad view has dismissed its modal content, returning control to your application.
 *
 * Your implementation of this method should resume any application activity that was paused
 * in response to `willLoadViewForAd:`.
 *
 * @param view The ad view sending the message.
 * @see `willLoadViewForAd:`
 */
- (void)didLoadViewForAd:(EBAdView *)view;

/**
 * Sent when a user is about to leave your application as a result of tapping
 * on an ad.
 *
 * Your application will be moved to the background shortly after this method is called.
 *
 * @param view The ad view sending the message.
 */
- (void)willLeaveApplicationFromAd:(EBAdView *)view;

@end

@protocol EBAdViewOverrideDelegate

- (BOOL)shouldOverrideClick:(EBAdView *)view originalURL:(NSURL *)url;

@end
