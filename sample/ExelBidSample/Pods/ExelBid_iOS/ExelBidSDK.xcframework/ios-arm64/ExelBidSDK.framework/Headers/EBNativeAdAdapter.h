//
//  EBNativeAdAdapter.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EBNativeAdAdapter;

/**
 * Classes that conform to the `EBNativeAdAdapter` protocol can have an
 * `EBNativeAdAdapterDelegate` delegate object. You use this delegate to communicate
 * native ad events (such as impressions and clicks occurring) back to the ExelBid SDK.
 */
@protocol EBNativeAdAdapterDelegate <NSObject>

@required

/**
 * Asks the delegate for a view controller to use for presenting modal content, such as the in-app
 * browser that can appear when an ad is tapped.
 *
 * @return A view controller that should be used for presenting modal content.
 */
- (UIViewController *)viewControllerForPresentingModalView;

/**
 * You should call this method when your adapter's modal is about to be presented.
 *
 * @param adapter The adapter that will present the modal.
 */
- (void)nativeAdWillLoadForAdapter:(id<EBNativeAdAdapter>)adapter;

/**
 * You should call this method when your adapter's modal has been dismissed.
 *
 * @param adapter The adapter that dismissed the modal.
 */
- (void)nativeAdDidLoadForAdapter:(id<EBNativeAdAdapter>)adapter;

/**
 * You should call this method when your the user will leave the application due to interaction with the ad.
 *
 * @param adapter The adapter that represents the ad that caused the user to leave the application.
 */
- (void)nativeAdWillLeaveApplicationFromAdapter:(id<EBNativeAdAdapter>)adapter;

@optional

/**
 * This method is called before the backing native ad logs an impression.
 *
 * @param adAdapter You should pass `self` to allow the ExelBid SDK to associate this event with the
 * correct instance of your ad adapter.
 */
- (void)nativeAdWillLogImpression:(id<EBNativeAdAdapter>)adAdapter;

/**
 * This method is called when the user interacts with the ad.
 *
 * @param adAdapter You should pass `self` to allow the ExelBid SDK to associate this event with the
 * correct instance of your ad adapter.
 */
- (void)nativeAdDidClick:(id<EBNativeAdAdapter>)adAdapter;

- (BOOL)nativeAdOverrideClick:(id<EBNativeAdAdapter>)adAdapter originalURL:(NSURL *)URL;

@end

/**
 * The `EBNativeAdAdapter` protocol allows the ExelBid SDK to interact with native ad objects obtained
 * from third-party ad networks. An object that adopts this protocol acts as a wrapper for a native
 * ad object, translating its proprietary interface into a common one that the ExelBid SDK can
 * understand.
 *
 * An object that adopts this protocol must implement the `properties` property to specify a
 * dictionary of assets, such as title and text, that should be rendered as part of a native ad.
 * When possible, you should place values in the returned dictionary such that they correspond to
 * the pre-defined keys in the EBNativeAdConstants header file.
 *
 * An adopting object must additionally implement -displayContentForURL:rootViewController:completion:
 * to supply the behavior that should occur when the user interacts with the ad.
 *
 * Optional methods of the protocol allow the adopting object to define when and how impressions
 * and interactions should be tracked.
 */
@protocol EBNativeAdAdapter <NSObject>

@required

/** @name Ad Resources */

/**
 * Provides a dictionary of all publicly accessible assets (such as title and text) for the
 * native ad.
 *
 * When possible, you should place values in the returned dictionary such that they correspond to
 * the pre-defined keys in the EBNativeAdConstants header file.
 */
@property (nonatomic, readonly) NSDictionary *properties;

/**
 * The default click-through URL for the ad.
 *
 * This may safely be set to nil if your network doesn't expose this value (for example, it may only
 * provide a method to handle a click, lacking another for retrieving the URL itself).
 */
@property (nonatomic, readonly) NSURL *defaultActionURL;

/** @name Handling Ad Interactions */

@optional

/**
 * Tells the object to open the specified URL using an appropriate mechanism.
 *
 * @param URL The URL to be opened.
 * @param controller The view controller that should be used to present the modal view controller.
 *
 * Your implementation of this method should either forward the request to the underlying
 * third-party ad object (if it has built-in support for handling ad interactions), or open an
 * in-application modal web browser or a modal App Store controller.
 */
- (void)displayContentForURL:(NSURL *)URL rootViewController:(UIViewController *)controller;

/**
 * Determines whether EBNativeAd should track clicks
 *
 * If not implemented, this will be assumed to return NO, and EBNativeAd will track clicks.
 * If this returns YES, then EBNativeAd will defer to the EBNativeAdAdapterDelegate callbacks to
 * track clicks.
 */
- (BOOL)enableThirdPartyClickTracking;

/**
 * Tracks a click for this ad.
 *
 * To avoid reporting discrepancies, you should only implement this method if the third-party ad
 * network requires clicks to be reported manually.
 */
- (void)trackClick;

/**
 * The `EBNativeAdAdapterDelegate` to send messages to as events occur.
 *
 * The `delegate` object defines several methods that you should call in order to inform ExelBid
 * of interactions with the ad. This delegate needs to be implemented if third party impression and/or
 * click tracking is enabled.
 */
@property (nonatomic, weak) id<EBNativeAdAdapterDelegate> delegate;

/** @name Responding to an Ad Being Attached to a View */

/**
 * This method will be called when your ad's content is about to be loaded into a view.
 *
 * @param view A view that will contain the ad content.
 *
 * You should implement this method if the underlying third-party ad object needs to be informed
 * of this event.
 */
- (void)willAttachToView:(UIView *)view;

/**
 * This method will be called if your implementation provides a DAA icon through the properties dictionary
 * and the user has tapped the icon.
 */
- (void)displayContentForDAAIconTap;
- (void)displayContentForDAAIconTap2:(NSString *)url;

/**
 * Return your ad's privacy information icon view.
 *
 * You should implement this method if your ad supplies its own view for its privacy information icon.
 */
- (UIView *)privacyInformationIconView;

/**
 * Return your ad's main media view.
 *
 * You should implement this method if your ad supplies its own view for the main media view which is typically
 * an image or video. If you implement this method, the SDK will not make any other attempts at retrieving
 * the main media asset.
 */
- (UIView *)mainMediaView;

@end
