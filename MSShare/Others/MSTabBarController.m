//
//  MSViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSEssenceViewController.h"
#import "MSFollowViewController.h"
#import "MSMeViewController.h"
#import "MSNewViewController.h"
#import "MSNavigationController.h"
#import "MSTabBar.h"

@interface MSTabBarController ()

@end

@implementation MSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加字控制器
    [self setUpAllChildViewController];
    //设置tabbar文字属性
    [self setUpItemAttr];
    //设置tabbar
    [self setTabBar];
}

- (void)setUpAllChildViewController {
    
    [self setUpOneChildViewController:[[MSEssenceViewController alloc] init] withTitle: @"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setUpOneChildViewController:[[MSNewViewController alloc] init] withTitle: @"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setUpOneChildViewController:[[MSFollowViewController alloc] init] withTitle: @"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    [self setUpOneChildViewController:[[MSMeViewController alloc] init] withTitle: @"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];

}

- (void)setUpOneChildViewController:(UIViewController *)vc withTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    MSNavigationController *nav = [[MSNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    if (image.length) {
        nav.tabBarItem.image = [UIImage imageNamed:image];
        nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
    [self addChildViewController:nav];
}

- (void)setUpItemAttr {
    UITabBarItem *item = [UITabBarItem appearance];
    //普通状态
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    //选中状态
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
}

- (void)setTabBar {
    [self setValue:[[MSTabBar alloc] init] forKey: @"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
