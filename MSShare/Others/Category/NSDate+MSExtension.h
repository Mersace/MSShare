//
//  NSDate+MSExtension.h
//  MSShare
//
//  Created by Ashscar on 17/5/25.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MSExtension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
