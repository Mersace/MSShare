//
//  MSTabBar.m
//  MSShare
//
//  Created by Ashscar on 17/5/4.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSTabBar.h"

@interface MSTabBar()
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation MSTabBar

#pragma mark -- 懒加载
- (UIButton *)publishButton {
    if (!_publishButton) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publishButton];
        _publishButton = publishButton;
    }
    return _publishButton;
}

#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //设置按钮
    CGFloat buttonW = self.ms_width/5;
    CGFloat buttonH = self.ms_height;
    CGFloat buttonY = 0;
    int buttonIndex = 0;
    for (UIView *subView in self.subviews) {
        //过滤掉非UITabBarButton 其实只有一个——UIBarButtonBackgroud
        //MSLog(@"%@", subView.class);
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        //设置frame
        CGFloat buttonX = buttonW * buttonIndex;
        if (buttonIndex > 1) {
            buttonX += buttonW;
        }
        subView.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonIndex++;
    }
    //设置发布按钮
    self.publishButton.ms_width = buttonW;
    self.publishButton.ms_height = buttonH;
    self.publishButton.ms_centerX = self.ms_width * 0.5;
    self.publishButton.ms_centerY = self.ms_height * 0.5;
}

- (void)publishClick {
    MSFunc;
}

@end
