//
//  EBNativeAdRenderingImageLoader.h
//  ExelbidSDK
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EBNativeAdRendererImageHandler;


@interface EBNativeAdRenderingImageLoader : NSObject

- (instancetype)initWithImageHandler:(EBNativeAdRendererImageHandler *)imageHandler;

- (void)loadImageForURL:(NSURL *)url intoImageView:(UIImageView *)imageView;

@end
