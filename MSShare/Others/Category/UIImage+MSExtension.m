//
//  UIImage+MSExtension.m
//  MSShare
//
//  Created by Ashscar on 17/5/8.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "UIImage+MSExtension.h"

@implementation UIImage (MSExtension)

+ (instancetype)originalImageWithName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
