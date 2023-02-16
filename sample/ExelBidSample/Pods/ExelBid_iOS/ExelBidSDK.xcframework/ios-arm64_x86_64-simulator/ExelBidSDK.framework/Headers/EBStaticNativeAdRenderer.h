//
//  EBStaticNativeAdRenderer.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ExelBidSDK/EBNativeAdRenderer.h>

@class EBNativeAdRendererConfiguration;
@class EBStaticNativeAdRendererSettings;

@interface EBStaticNativeAdRenderer : NSObject<EBNativeAdRenderer>

@property (nonatomic, readonly) EBNativeViewSizeHandler viewSizeHandler;

+ (EBNativeAdRendererConfiguration *)rendererConfigurationWithRendererSettings:(id<EBNativeAdRendererSettings>)rendererSettings;


@end
