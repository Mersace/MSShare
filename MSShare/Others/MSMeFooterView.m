//
//  MSMeFooterView.m
//  MSShare
//
//  Created by Ashscar on 17/5/21.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSMeFooterView.h"
#import "MSMeSquare.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "MSMeSquareButton.h"
#import "MSMeWebViewController.h"

@implementation MSMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"https://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nonnull responseObject) {
            // 字典数组 -> 模型数组
            NSArray *squares = [MSMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            // 根据模型数据创建对应的控件
            [self createSquares:squares];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            MSLog(@"请求失败 - %@", error);
        }];
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */
- (void)createSquares:(NSArray *)squares
{
    // 方块个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4; // 一行的最大列数
    CGFloat buttonW = self.ms_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        // i位置对应的模型数据
        MSMeSquare *square = squares[i];
        
        // 创建按钮
        MSMeSquareButton *button = [MSMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.ms_x = (i % maxColsCount) * buttonW;
        button.ms_y = (i / maxColsCount) * buttonH;
        button.ms_width = buttonW;
        button.ms_height = buttonH;
        
        // 设置数据
        button.square = square;
        //        [button.imageView sd_setImageWithURL:[NSURL URLWithString:square.icon] placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
        
        //        [button setImage:[UIImage imageNamed:@"setup-head-default"] forState:UIControlStateNormal];
        //        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        //            [button setImage:image forState:UIControlStateNormal];
        //        }];
    }
    // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.ms_height = self.subviews.lastObject.ms_bottom;
    
    // 设置tableView的contentSize
    UITableView *tableView = (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData]; // 重新刷新数据(会重新计算contentSize)
    //    tableView.contentSize = CGSizeMake(0, self.xmg_bottom); // 不靠谱
    
}

- (void)buttonClick:(MSMeSquareButton *)button
{
    NSString *url = button.square.url;
    
    if ([url hasPrefix:@"http"]) { // 利用webView加载url即可
        // 使用SFSafariViewController显示网页
        //        SFSafariViewController *webView = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        //        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        //        [tabBarVc presentViewController:webView animated:YES completion:nil];
        
        
        // 获得"我"模块对应的导航控制器
        //        UITabBarController *tabBarVc = [UIApplication sharedApplication].keyWindow.rootViewController;
        //        UINavigationController *nav = tabBarVc.childViewControllers.firstObject;
        UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBarVc.selectedViewController;
        
        // 显示XMGWebViewController
        MSMeWebViewController *webView = [[MSMeWebViewController alloc] init];
        webView.url = url;
        webView.navigationItem.title = button.currentTitle;
        [nav pushViewController:webView animated:YES];
    } else if ([url hasPrefix:@"mod"]) { // 另行处理
        if ([url hasSuffix:@"BDJ_To_Check"]) {
            MSLog(@"跳转到[审帖]界面");
        } else if ([url hasSuffix:@"BDJ_To_RecentHot"]) {
            MSLog(@"跳转到[每日排行]界面");
        } else {
            MSLog(@"跳转到其他界面");
        }
    } else {
            MSLog(@"不是http或者mod协议的");
    }
}

@end
