//
//  MSLoginRegisterTextField.m
//  MSShare
//
//  Created by Ashscar on 17/5/19.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSLoginRegisterTextField.h"

@implementation MSLoginRegisterTextField


- (void)awakeFromNib {
    //设置光标颜色
    self.tintColor = [UIColor whiteColor];
    //设置站位文字
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dict];
    
    [super awakeFromNib];
}

//方法重写
//- (CGRect)placeholderRectForBounds:(CGRect)bounds {
//    return CGRectMake(0, 0, 40, 10);
//}

//- (void)drawPlaceholderInRect:(CGRect)rect {
//    
//}


@end
