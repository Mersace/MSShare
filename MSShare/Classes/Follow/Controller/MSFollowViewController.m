//
//  MSFollowViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSFollowViewController.h"
#import "MSRecommandViewController.h"
#import "MSLoginRegisterViewController.h"
@interface MSFollowViewController ()

@end

@implementation MSFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MSCommonBGColor;
    // 标题(不建议使用self.title属性)
    self.navigationItem.title = @"我的关注";
    // 左边
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    //    [button setImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    //    [button addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    //    [button sizeToFit];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"立即登录/注册" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [loginButton sizeToFit];
    loginButton.center = CGPointMake(self.view.ms_centerX, self.view.ms_centerY);
    [self.view addSubview:loginButton];
    
}

- (void)followClick {
    MSRecommandViewController *vc = [[MSRecommandViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)login {
    MSLoginRegisterViewController *vc = [[MSLoginRegisterViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
