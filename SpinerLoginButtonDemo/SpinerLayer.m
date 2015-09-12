//
//  SpinerLayer.m
//  SpinerLoginButtonDemo
//
//  Created by Qianhan on 15/9/8.
//  Copyright (c) 2015年 soffice. All rights reserved.
//

#import "SpinerLayer.h"

@implementation SpinerLayer

- (instancetype)initFrame:(CGRect)frame {

    if (self = [super init]) {
        
        UIBezierPath *path = [[UIBezierPath alloc] init];
        self.frame      = CGRectMake(0.0, 0.0, frame.size.height, frame.size.height);
        CGPoint center  = CGPointMake(frame.size.height / 2, self.bounds.size.height / 2);
        CGFloat radius  = (frame.size.height / 2) * 0.5;
        
        [path addArcWithCenter:center
                        radius:radius
                    startAngle:0 - M_PI_2
                      endAngle:M_PI * 2 - M_PI_2
                     clockwise:YES];
        
        self.fillColor      = [UIColor clearColor].CGColor;
        self.strokeColor    = [UIColor whiteColor].CGColor;
        self.lineWidth      = 1.0;
        self.path           = path.CGPath;
        self.strokeEnd      = 0.4;
        self.hidden         = YES;
    }
    return self;
}

- (void)startAnimation {
    
    self.hidden = NO;
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue  = [NSNumber numberWithFloat:0.0];
    rotation.toValue    = [NSNumber numberWithFloat:M_PI * 2];
    rotation.duration   = 0.4;
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    rotation.repeatCount    = HUGE;
    rotation.fillMode       = kCAFillModeForwards;
    rotation.removedOnCompletion    = NO;
    
    [self addAnimation:rotation forKey:rotation.keyPath];
}

- (void)stopAnimation {

    self.hidden = YES;
    [self removeAllAnimations];
}


@end
