//
//  MSSettingViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/4.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSSettingViewController.h"
#import "MSClearCacheCell.h"
#import "MSOtherCell.h"

@interface MSSettingViewController ()

@end

@implementation MSSettingViewController

static NSString *const MSClearCellID = @"MSClearCell";
static NSString *const MSOtherCellID = @"MSOtherCell";
static NSString *const MSSettingCellID = @"MSSettingCell";

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MSCommonBGColor;
    self.navigationItem.title = @"设置";
    //注册
    [self.tableView registerClass:[MSClearCacheCell class] forCellReuseIdentifier:MSClearCellID];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:MSSettingCellID];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MSOtherCell class]) bundle:nil] forCellReuseIdentifier:MSOtherCellID];
}

#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 10;
    if (section == 1) return 5;
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清除缓存cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        //        XMGClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGClearCacheCellId];
        //
        //        // cell重新显示的时候, 继续转圈圈
        //        UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)cell.accessoryView;
        //        [loadingView startAnimating];
        //
        //        return cell;
        
        return [tableView dequeueReusableCellWithIdentifier:MSClearCellID];
    } else if (indexPath.row == 2) {
        //        XMGOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:XMGOtherCellId];
        //        cell.data = data;
        //        return cell;
        
        return [tableView dequeueReusableCellWithIdentifier:MSOtherCellID];
    }
    
    // 其他cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MSSettingCellID];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    return cell;
}



@end
