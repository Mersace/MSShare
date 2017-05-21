//
//  UIBarButtonItem+MSExtension.h
//  MSShare
//
//  Created by Ashscar on 17/5/8.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MSExtension)
+ (UIBarButtonItem *)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;
@end
