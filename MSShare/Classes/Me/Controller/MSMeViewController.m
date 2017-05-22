//
//  MSMeViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSMeViewController.h"
#import "MSSettingViewController.h"
#import "MSMeFooterView.h"
#import "MSMeCell.h"
@interface MSMeViewController ()

@end

@implementation MSMeViewController

//在init方法中设置tabbleview的样式
- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpNav];
    
}

- (void)setUpTableView {
    self.tableView.backgroundColor = MSCommonBGColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MSMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(MSMargin - 35, 0, 0, 0);
    
    // 设置footer
    self.tableView.tableFooterView = [[MSMeFooterView alloc] init];
}

- (void)setUpNav {
    self.view.backgroundColor = MSCommonBGColor;
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

#pragma mark -- <UITableViewDataSource> start --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //设置cell标识
    static NSString *ID = @"cell";
    MSMeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MSMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 4.设置数据
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    } else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    return cell;
}
#pragma mark -- <UITableViewDataSource> end  --


#pragma mark -- <UITableViewDelegate> start --


#pragma mark -- <UITableViewDelegate> end  --
@end
