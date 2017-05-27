//
//  MSShare
//
//  Created by Ashscar on 17/5/24.
//  Copyright © 2017年 Ashscar. All rights reserved.
//
#import "MSTopicCell.h"
#import "MSTopic.h"
#import "MSUser.h"
#import "MSComment.h"
#import <UIImageView+WebCache.h>
#import "MSTopicVideoView.h"
#import "MSTopicVoiceView.h"
#import "MSTopicPictureView.h"

@interface MSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/* 中间控件 */
/** 图片控件 */
@property (nonatomic, weak) MSTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) MSTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) MSTopicVideoView *videoView;
@end

@implementation MSTopicCell
#pragma mark - 懒加载
- (MSTopicPictureView *)pictureView
{
    if (!_pictureView) {
        MSTopicPictureView *pictureView = [MSTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (MSTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        MSTopicVoiceView *voiceView = [MSTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (MSTopicVideoView *)videoView
{
    if (!_videoView) {
        MSTopicVideoView *videoView = [MSTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (IBAction)more {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[举报]按钮");
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    
    [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
}

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopic:(MSTopic *)topic
{
    _topic = topic;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createdAtLabel.text = topic.created_at; // 调用get方法[topic created_at];
    self.text_label.text = topic.text;
    
    [self setupButton:self.dingButton number:topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:topic.cai placeholder:@"踩"];
    [self setupButton:self.repostButton number:topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:topic.comment placeholder:@"评论"];
    
    
    //    NSString *str = @"";
    //    if (str.length) {
    //
    //    }
    
    
    // 没有最热评论
    // topic.top_cmt = @[];
    
    // 有最热评论
    // topic.top_cmt = @[@{}];
    
    // 最热评论 不能用if (topic.top_cmt)
    // if (topic.top_cmt.count) { // 有最热评论
    
    if (topic.top_cmt) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSString *username = topic.top_cmt.user.username; // 用户名
        NSString *content = topic.top_cmt.content; // 评论内容
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    // 中间内容
#pragma mark - 根据MSTopic模型数据的情况来决定中间添加什么控件(内容)
    if (topic.type == MSTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == MSTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == MSTopicTypeWord) { // 段子
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == MSTopicTypePicture) { // 图片
        self.pictureView.hidden = NO;
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
        
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= MSMargin;
    frame.origin.y += MSMargin;
    
    [super setFrame:frame];
}

@end
