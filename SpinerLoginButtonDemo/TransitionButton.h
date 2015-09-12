//
//  TransitionButton.h
//  SpinerLoginButtonDemo
//
//  Created by Qianhan on 15/9/12.
//  Copyright (c) 2015年 soffice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransitionButton : UIButton

@property (strong, nonatomic) UIColor       *normalColor;
@property (strong, nonatomic) UIColor       *highlightColor;

- (void)startLoadingAnimation;
- (void)finishedAnimation;
- (void)failedAnimation;

@end
