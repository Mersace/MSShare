//
//  UIView+MSExtension.m
//  5期-百思不得姐
//
//  Created by Ashscar on 17/1/6.
//  Copyright Ashscar All rights reserved.
//

#import "UIView+MSExtension.h"

@implementation UIView (MSExtension)

- (CGSize)ms_size
{
    return self.frame.size;
}

- (void)setMs_size:(CGSize)ms_size
{
    CGRect frame = self.frame;
    frame.size = ms_size;
    self.frame = frame;
}

- (CGFloat)ms_width
{
    return self.frame.size.width;
}

- (CGFloat)ms_height
{
    return self.frame.size.height;
}

- (void)setMs_width:(CGFloat)ms_width
{
    CGRect frame = self.frame;
    frame.size.width = ms_width;
    self.frame = frame;
}

- (void)setMs_height:(CGFloat)ms_height
{
    CGRect frame = self.frame;
    frame.size.height = ms_height;
    self.frame = frame;
}

- (CGFloat)ms_x
{
    return self.frame.origin.x;
}

- (void)setMs_x:(CGFloat)ms_x
{
    CGRect frame = self.frame;
    frame.origin.x = ms_x;
    self.frame = frame;
}

- (CGFloat)ms_y
{
    return self.frame.origin.y;
}

- (void)setMs_y:(CGFloat)ms_y
{
    CGRect frame = self.frame;
    frame.origin.y = ms_y;
    self.frame = frame;
}

- (CGFloat)ms_centerX
{
    return self.center.x;
}

- (void)setMs_centerX:(CGFloat)ms_centerX
{
    CGPoint center = self.center;
    center.x = ms_centerX;
    self.center = center;
}

- (CGFloat)ms_centerY
{
    return self.center.y;
}

- (void)setMs_centerY:(CGFloat)ms_centerY
{
    CGPoint center = self.center;
    center.y = ms_centerY;
    self.center = center;
}

- (CGFloat)ms_right
{
//    return self.ms_x + self.ms_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ms_bottom
{
//    return self.ms_y + self.ms_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setMs_right:(CGFloat)ms_right
{
    self.ms_x = ms_right - self.ms_width;
}

- (void)setMs_bottom:(CGFloat)ms_bottom
{
    self.ms_y = ms_bottom - self.ms_height;
}
+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
