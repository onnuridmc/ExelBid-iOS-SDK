//
//  EBHTMLDialogView.m
//  ExelbidSample
//
//  Created by HeroK on 2016. 11. 15..
//  Copyright © 2016년 Zionbi. All rights reserved.
//

#import "EBHTMLDialogView.h"

@implementation EBHTMLDialogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.6f;
        [self addSubview:backView];
        
        UIView *adBackView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width-40, frame.size.height-40)];
        adBackView.backgroundColor = [UIColor whiteColor];
        [self addSubview:adBackView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, adBackView.frame.size.width-40, 50)];
        [titleLabel setText:@"종료"];
        [titleLabel setTextColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [titleLabel setFont:[UIFont systemFontOfSize:20.0f]];
        [adBackView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [adBackView addSubview:lineView];
        
        self.adView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, adBackView.frame.size.width, adBackView.frame.size.height - 110)];
        [adBackView addSubview:self.adView];
        
        self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, adBackView.frame.size.height - 60, adBackView.frame.size.width/2 - 20, 50)];
        [self.closeButton setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [self.closeButton setTintColor:[UIColor whiteColor]];
        [self.closeButton setTitle:@"종료" forState:UIControlStateNormal];
        [self.closeButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.closeButton.layer setCornerRadius:5.0f];
        [self.closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
        [adBackView addSubview:self.closeButton];
        
        self.cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(adBackView.frame.size.width/2+10, adBackView.frame.size.height - 60, adBackView.frame.size.width/2 - 20, 50)];
        [self.cancleButton setBackgroundColor:[UIColor colorWithWhite:0.3f alpha:1.0f]];
        [self.cancleButton setTintColor:[UIColor whiteColor]];
        [self.cancleButton setTitle:@"취소" forState:UIControlStateNormal];
        [self.cancleButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.cancleButton.layer setCornerRadius:5.0f];
        [self.cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
        [adBackView addSubview:self.cancleButton];
    }
    return self;
}

- (void)cancleClick {
    [self removeFromSuperview];
}

- (void)closeClick {
    exit(0);
}
@end
