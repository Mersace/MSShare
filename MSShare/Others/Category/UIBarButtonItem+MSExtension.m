//
//  UIBarButtonItem+MSExtension.m
//  MSShare
//
//  Created by Ashscar on 17/5/8.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "UIBarButtonItem+MSExtension.h"

@implementation UIBarButtonItem (MSExtension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
