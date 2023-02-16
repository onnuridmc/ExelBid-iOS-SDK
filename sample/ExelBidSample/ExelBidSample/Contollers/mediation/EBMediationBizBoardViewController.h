//
//  EBMediationBizBoardViewController.h
//
//  Created by Jaeuk Jeong on 2023/02/09.
//

#import <UIKit/UIKit.h>
#import "EBAdInfo.h"

@interface EBMediationBizBoardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *adViewContainer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *failLabel;
@property (weak, nonatomic) IBOutlet UITextView *logView;

@property (nonatomic, strong) EBAdInfo *info;

@end
