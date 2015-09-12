//
//  TransitionButton.m
//  SpinerLoginButtonDemo
//
//  Created by Qianhan on 15/9/12.
//  Copyright (c) 2015年 soffice. All rights reserved.
//

#import "TransitionButton.h"

#import "SpinerLayer.h"

static const CFTimeInterval shrinkDuration = 0.1;
@interface TransitionButton ()

@property (copy, nonatomic)     SpinerLayer     *spinerLayer;
@property (strong, nonatomic)   NSString        *cachedTitle;
@property (assign, nonatomic)   CGFloat         selfWidth;

@end

@implementation TransitionButton

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        
        [self.layer  addSublayer:self.spinerLayer];
        [self setup];
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    CABasicAnimation    *animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"]) {
        
        [self returnToOrginalState];
    } else if ([animation.keyPath isEqualToString:@"bounds.size.width"]) {
    
        [self returnToOrginalState];
    } else {
    
    }
}

#pragma mark - getter/setter
- (SpinerLayer *)spinerLayer {

    if (!_spinerLayer) {
    
        _spinerLayer    = [[SpinerLayer alloc] initFrame:CGRectMake(0.0,
                                                                    0.0,
                                                                    self.frame.size.width,
                                                                    self.frame.size.height)];
        _spinerLayer.backgroundColor    = [UIColor clearColor].CGColor;
    }
    return _spinerLayer;
}

@synthesize normalColor = _normalColor;
- (UIColor *)normalColor {
    
    if (!_normalColor) {
        _normalColor = [UIColor colorWithRed:0.992157
                                       green:0.215686
                                        blue:0.403922
                                       alpha:1.0];
    }
    return _normalColor;
}

- (void)setNormalColor:(UIColor *)normalColor {
    
    _normalColor            = normalColor;
    self.backgroundColor    = normalColor;
}

@synthesize highlightColor = _highlightColor;
- (UIColor *)highlightColor {
    
    if (!_highlightColor) {
        
        _highlightColor = [UIColor colorWithRed:0.798012
                                          green:0.171076
                                           blue:0.321758
                                          alpha:1.0];
    }
    return _highlightColor;
}

- (void)setHighlightColor:(UIColor *)highlightColor {
    
    _highlightColor = highlightColor;
}

- (void)setHighlighted:(BOOL)highlighted {

    if (highlighted) {
        
        self.backgroundColor = self.highlightColor;
    } else {
        
        self.backgroundColor = self.normalColor;
    }
}

#pragma mark - public method
- (void)startLoadingAnimation {
    
    self.cachedTitle        = self.titleLabel.text;
    [self setTitle:@"" forState:UIControlStateNormal];
    [self shrink];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        [self.spinerLayer startAnimation];
    });
}

- (void)finishedAnimation {
    
    [self.spinerLayer stopAnimation];
    [self expand];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.3 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       
        [self returnToOrginalState];
    });
}

- (void)failedAnimation {

    [self revert];
    [self.spinerLayer stopAnimation];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        [self returnToOrginalState];
    });
}

#pragma mark - private method
- (void)setup {

    self.layer.cornerRadius = self.frame.size.height / 2;
    self.clipsToBounds      = YES;
    self.backgroundColor    = self.normalColor;
    self.selfWidth          = self.frame.size.width;
}

// 收缩
- (void)shrink {

    CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    shrinkAnimation.fromValue   = [NSNumber numberWithFloat:self.frame.size.width];
    shrinkAnimation.toValue     = [NSNumber numberWithFloat:self.frame.size.height];
    shrinkAnimation.duration    = shrinkDuration;
    shrinkAnimation.fillMode    = kCAFillModeForwards;
    shrinkAnimation.removedOnCompletion = NO;
    shrinkAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer  addAnimation:shrinkAnimation forKey:shrinkAnimation.keyPath];
}

// 还原
- (void)revert {

    CABasicAnimation *revertAnimation = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
    
    revertAnimation.fromValue   = [NSNumber numberWithFloat:self.frame.size.height];
    revertAnimation.toValue     = [NSNumber numberWithFloat:self.selfWidth];
    revertAnimation.duration    = 0.1;
    revertAnimation.fillMode    = kCAFillModeForwards;
    revertAnimation.removedOnCompletion = YES;
    revertAnimation.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.layer  addAnimation:revertAnimation forKey:revertAnimation.keyPath];
}

// 展开
- (void)expand {

    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    expandAnimation.fromValue   = [NSNumber numberWithFloat:1.0];
    expandAnimation.toValue     = [NSNumber numberWithFloat:26.0];
    expandAnimation.duration    = 0.3;
    expandAnimation.removedOnCompletion = NO;
    expandAnimation.timingFunction      = [CAMediaTimingFunction functionWithControlPoints:0.95 :0.02 :1.0 :0.05];
    
    [self.layer  addAnimation:expandAnimation forKey:expandAnimation.keyPath];
}

- (void)returnToOrginalState {

    [self.layer removeAllAnimations];
    [self setTitle:self.cachedTitle forState:UIControlStateNormal];
}


@end
