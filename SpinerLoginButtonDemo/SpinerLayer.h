//
//  SpinerLayer.h
//  SpinerLoginButtonDemo
//
//  Created by Qianhan on 15/9/8.
//  Copyright (c) 2015年 soffice. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface SpinerLayer : CAShapeLayer

- (instancetype)initFrame:(CGRect)frame;
- (void)startAnimation;
- (void)stopAnimation;

@end
