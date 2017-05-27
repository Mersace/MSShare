//
//  MSTopicViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/25.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSTopicViewController.h"
#import "MSTopic.h"
#import "MSTopicCell.h"
#import "MSRefreshHeader.h"
#import "MSRefreshFooter.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "MSNewViewController.h"

@interface MSTopicViewController ()
/** 所有的帖子数据 */
@property (nonatomic, strong) NSMutableArray<MSTopic *> *topics;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者*/
@property (nonatomic, strong) AFHTTPSessionManager *manager;
/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;

@end

@implementation MSTopicViewController

#pragma mark - 仅仅是为了消除编译器发出的警告 : type方法没有实现
- (MSTopicType)type {
    return 0;
}

- (NSString *)aParam
{
    //    if ([NSStringFromClass(self.parentViewController.class) isEqualToString:@"XMGNewViController"]) {
    //        return @"newlist";
    //    }
    //    return @"list";
    
    if (self.parentViewController.class == [MSNewViewController class]) {
        return @"newlist";
    }
    return @"list";
    
    //    if ([self.parentViewController isKindOfClass:[XMGNewViewController class]]) {
    //        return @"newlist";
    //    }
    //    return @"list";
    
    // 错误做法
    //    if ([self.parentViewController isKindOfClass:[XMGEssenceViewController class]]) {
    //        return @"list";
    //    }
    //    return @"newlist";
}

static NSString *const MSTopicCellID = @"topic";

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpRefresh];
}

- (void)setUpTableView {
    self.tableView.backgroundColor = MSCommonBGColor;
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MSTopicCell class]) bundle:nil] forCellReuseIdentifier:MSTopicCellID];
    self.tableView.rowHeight = 250;
}

- (void)setUpRefresh {
    self.tableView.mj_header = [MSRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadnNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MSRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

//加载新数据
- (void)loadnNewTopics {
    //先取消所有请求
    // 取消所有请求
    //    for (NSURLSessionTask *task in self.manager.tasks) {
    //        [task cancel];
    //    }
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 关闭NSURLSession + 取消所有请求
    // [self.manager invalidateSessionCancelingTasks:YES];
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        self.topics = [MSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MSLog(@"刷新失败");
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
    }];
}

//加载更多数据
- (void)loadMoreTopics {
    //先取消所有请求
    // 取消所有请求
    //    for (NSURLSessionTask *task in self.manager.tasks) {
    //        [task cancel];
    //    }
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 存储这页对应的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<MSTopic *> *moreTopics = [MSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MSLog(@"请求失败 - %@", error);
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:MSTopicCellID];
    MSTopic *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topics[indexPath.row].cellHeight;
}



@end
