//
//  EBServerAdPositioning.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 11..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <ExelBidSDK/EBAdPositioning.h>

/**
 * The `EBServerAdPositioning` class is a model that allows you to control the positions where
 * native advertisements should appear within a stream. A server positioning object works in
 * conjunction with an ad placer, telling the ad placer that it should retrieve positioning
 * information from the ExelBid ad server.
 *
 * Unlike `EBClientAdPositioning`, which represents hard-coded positioning information, a server
 * positioning object offers you the benefit of modifying your ad positions via the ExelBid website,
 * without rebuilding your application.
 */

@interface EBServerAdPositioning : EBAdPositioning

/** @name Creating a Server Positioning Object */

/**
 * Creates and returns a server positioning object.
 *
 * When an ad placer is set to use server positioning, it will ask the ExelBid ad server for the
 * positions where ads should be inserted into a given stream. These positioning values are
 * configurable on the ExelBid website.
 *
 * @return The newly created positioning object.
 *
 * @see EBClientAdPositioning
 */
+ (instancetype)positioning;

@end
