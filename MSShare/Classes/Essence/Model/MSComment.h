//
//  MSComment.h
//  MSShare
//
//  Created by Ashscar on 17/5/27.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MSUser;
@interface MSComment : NSObject
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 用户(发表评论的人) */
@property (nonatomic, strong) MSUser *user;
@end
