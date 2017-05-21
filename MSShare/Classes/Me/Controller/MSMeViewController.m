//
//  MSMeViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSMeViewController.h"
#import "MSSettingViewController.h"
@interface MSMeViewController ()

@end

@implementation MSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MSRandomColor;
    // 标题
    self.navigationItem.title = @"我的";
//    // 右边-设置
//    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
//    [settingButton setImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
//    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
//    [settingButton sizeToFit];
//    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithCustomView:settingButton];
//    // 右边-月亮
//    UIButton *moonButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
//    [moonButton setImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
//    [moonButton addTarget:self action:@selector(moonClick) forControlEvents:UIControlEventTouchUpInside];
//    [moonButton sizeToFit];
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
}

- (void)settingClick {
    [self.navigationController pushViewController:[[MSSettingViewController alloc] init] animated:YES];
}

- (void)moonClick {
    MSFunc;
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
