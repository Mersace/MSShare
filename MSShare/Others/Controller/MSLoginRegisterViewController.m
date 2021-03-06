//
//  MSLoginRegisterViewController.m
//  5期-百思不得姐
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSLoginRegisterViewController.h"

@interface MSLoginRegisterViewController ()

//@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@end

@implementation MSLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loginButton.layer.cornerRadius = 5;
//    [self.loginButton setValue:@5 forKeyPath:@"layer.cornerRadius"];
    
//    self.loginButton.layer.masksToBounds = YES;
//    [self.loginButton setValue:@YES forKeyPath:@"layer.masksToBounds"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

/**
 *  关闭当前界面
 */
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  显示登录\注册界面
 */
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
    
    // 设置约束 和 按钮状态
    if (self.leftMargin.constant) { // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        self.leftMargin.constant = 0;
        button.selected = NO;
//        [button setTitle:@"注册帐号" forState:UIControlStateNormal];
    } else { // 目前显示的是登录界面, 点击按钮后要切换为注册界面
        self.leftMargin.constant = - self.view.ms_width;
        button.selected = YES;
//        [button setTitle:@"已有帐号?" forState:UIControlStateNormal];
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.view endEditing:YES];
}
@end
