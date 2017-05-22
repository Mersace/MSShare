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

- (void)buttonClick:(UIButton *)button
{
    MSFunc;
}

@end
