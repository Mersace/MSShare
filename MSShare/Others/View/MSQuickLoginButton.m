//
//  MSQuickLoginButton.m
//  MSShare
//
//  Created by Ashscar on 17/5/9.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSQuickLoginButton.h"

@implementation MSQuickLoginButton

- (void)awakeFromNib {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.ms_y = 0;
    self.imageView.ms_centerX = self.ms_width/2;
    self.titleLabel.ms_x = 0;
    self.titleLabel.ms_y = self.imageView.ms_bottom;
    self.titleLabel.ms_width = self.ms_width;
    self.titleLabel.ms_height = self.ms_height - self.titleLabel.ms_y;
}

@end
