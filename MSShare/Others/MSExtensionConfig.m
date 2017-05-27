//
//  MSExtensionConfig.m
//  MSShare
//
//  Created by Ashscar on 17/5/27.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSExtensionConfig.h"
#import <MJExtension.h>
#import "MSTopic.h"
#import "MSComment.h"

@implementation MSExtensionConfig

+ (void)load {
    [MSTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [MSComment class]};
    }];
    
    [MSTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};
    }];

}

@end
