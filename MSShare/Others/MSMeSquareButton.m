//
//  MSMeSquareButton.m
//  MSShare
//
//  Created by Ashscar on 17/5/22.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSMeSquareButton.h"
#import "MSMeSquare.h"
#import <UIButton+WebCache.h>

@implementation MSMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.ms_y = self.ms_height * 0.15;
    self.imageView.ms_height = self.ms_height * 0.5;
    self.imageView.ms_width = self.imageView.ms_height;
    self.imageView.ms_centerX = self.ms_width * 0.5;
    
    self.titleLabel.ms_x = 0;
    self.titleLabel.ms_y = self.imageView.ms_bottom;
    self.titleLabel.ms_width = self.ms_width;
    self.titleLabel.ms_height = self.ms_height - self.titleLabel.ms_y;
}

- (void)setSquare:(MSMeSquare *)square {
    _square = square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}

@end
