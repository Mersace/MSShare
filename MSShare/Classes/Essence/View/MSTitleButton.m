//
//  MSTitleButton.m
//  MSShare
//
//  Created by Ashscar on 17/5/24.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSTitleButton.h"

@implementation MSTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置按钮颜色
        // self.selected = NO;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        // self.selected = YES;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
