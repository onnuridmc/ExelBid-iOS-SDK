//
//  EBNativeAdViewController.h
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 8..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBAdInfo.h"

@interface EBNativeAdViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *adViewContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *failLabel;

@property (nonatomic, strong) EBAdInfo *info;


@end
