//
//  ViewController.m
//  SpinerLoginButtonDemo
//
//  Created by Qianhan on 15/9/8.
//  Copyright (c) 2015年 soffice. All rights reserved.
//

#import "ViewController.h"

#import "TransitionButton.h"
#import "AppMacros.h"

@interface ViewController ()

@property (nonatomic, copy)  TransitionButton    *loginButton;
@property (nonatomic, copy)  TransitionButton    *customColorloginButton;
@property (nonatomic)        BOOL  isFailed;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view   addSubview:self.loginButton];
    [self.view   addSubview:self.customColorloginButton];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
}

- (TransitionButton *)loginButton {

    if (!_loginButton) {
        
        _loginButton    = [[TransitionButton alloc] initWithFrame:CGRectMake(20.0,
                                                                             self.view.frame.size.height - (100 + 44.0),
                                                                             self.view.frame.size.width - 20 * 2,
                                                                             44.0)];
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        [_loginButton addTarget:self
                         action:@selector(loginOnClick:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginButton;
}

- (TransitionButton *)customColorloginButton {
    
    if (!_customColorloginButton) {
        
        _customColorloginButton    = [[TransitionButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 120.0) / 2,
                                                                                        100,
                                                                                        120.0,
                                                                                        44.0)];
        [_customColorloginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_customColorloginButton addTarget:self
                                    action:@selector(customOnClick:)
                          forControlEvents:UIControlEventTouchUpInside];
        _customColorloginButton.normalColor     = UIColorFromRGB(0x33CCCC, 1.0);
        _customColorloginButton.highlightColor  = UIColorFromRGB(0x1FB8B8, 1.0);
    }
    return _customColorloginButton;
}

- (void)loginOnClick:(id)sender {

    self.loginButton.enabled    = NO;
    [self.loginButton startLoadingAnimation];

    // 模拟登录过程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(2.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        self.isFailed = !_isFailed;
        if (_isFailed) {
            
            [self.loginButton failedAnimation];
        } else {
            
            [self.loginButton finishedAnimation];
        }
                       self.loginButton.enabled    = YES;
    });
}

- (void)customOnClick:(id)sender {
    
    self.customColorloginButton.enabled = NO;
    [self.customColorloginButton startLoadingAnimation];
    
    // 模拟登录过程
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(2.0 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        
        self.isFailed = !_isFailed;
        if (_isFailed) {
            
            [self.customColorloginButton failedAnimation];
        } else {
            
            [self.customColorloginButton finishedAnimation];
        }
                       self.customColorloginButton.enabled  = YES;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
