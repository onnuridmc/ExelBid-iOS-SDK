//
//  EBNativeRoundView.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 16..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBNativeRoundView.h"

@implementation EBNativeRoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.6f;
        [self addSubview:backView];
        
        UIView *adBackView = [[UIView alloc] initWithFrame:CGRectMake(10, (frame.size.height-330)/2, frame.size.width-20, 330)];
        adBackView.backgroundColor = [UIColor whiteColor];
        adBackView.clipsToBounds = YES;
        [self addSubview:adBackView];
        
        [adBackView.layer setCornerRadius:10.0f];
        
        self.adView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, adBackView.frame.size.width, adBackView.frame.size.height)];
        [adBackView addSubview:self.adView];
        
        UIView *adlabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        [adlabelView setBackgroundColor:[UIColor blackColor]];
        [adlabelView setAlpha:0.5f];
        [adBackView addSubview:adlabelView];
        
        UILabel *adlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        [adlabel setText:@"AD"];
        [adlabel setTextColor:[UIColor whiteColor]];
        [adlabel setFont:[UIFont systemFontOfSize:10.0f]];
        [adlabel setTextAlignment:NSTextAlignmentCenter];
        [adBackView addSubview:adlabel];
        
        
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(adBackView.frame.size.width - 40, 10, 30, 30)];
        [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [adBackView addSubview:closeButton];
        
     }
    return self;
}

- (void)closeClick {
    [self removeFromSuperview];
}
@end
