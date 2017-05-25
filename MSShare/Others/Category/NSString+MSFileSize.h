//
//  NSString+MSFileSize.h
//  MSBS
//
//  Created by Ashscar on 17/3/28.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MSFileSize)
- (unsigned long long)fileSize;//给文件夹名，计算文件夹的大小
@end
