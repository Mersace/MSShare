//
//  MSEssenceViewController.m
//  MSShare
//
//  Created by Ashscar on 17/5/3.
//  Copyright © 2017年 Ashscar. All rights reserved.
//

#import "MSEssenceViewController.h"
#import "MSTitleButton.h"
#import "MSAllViewController.h"
#import "MSVideoViewController.h"
#import "MSVoiceViewController.h"
#import "MSPictureViewController.h"
#import "MSWordViewController.h"

@interface MSEssenceViewController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic, weak) MSTitleButton *selectedTitleButton;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** UIScrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;

@end

@implementation MSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    [self addAllChildViewController];
    [self setUpScrollView];
    [self setupTitlesView];
    [self addChildVcView];
}

//设置导航条
- (void)setUpNav {
    self.view.backgroundColor = MSRandomColor;
    //设置navigationItem
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

//添加所有子控制器
- (void)addAllChildViewController {
    MSAllViewController *all = [[MSAllViewController alloc] init];
    [self addChildViewController:all];
    
    MSVideoViewController *video = [[MSVideoViewController alloc] init];
    [self addChildViewController:video];
    
    MSVoiceViewController *voice = [[MSVoiceViewController alloc] init];
    [self addChildViewController:voice];
    
    MSPictureViewController *picture = [[MSPictureViewController alloc] init];
    [self addChildViewController:picture];
    
    MSWordViewController *word = [[MSWordViewController alloc] init];
    [self addChildViewController:word];
}

//设置scrollView
- (void)setUpScrollView {
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = MSCommonBGColor;
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    NSUInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(count * scrollView.ms_width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

//设置顶部指示器
- (void)setupTitlesView {
    // 标题栏
    UIView *titlesView = [[UIView alloc] init];
    //    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2];
    //    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.2];
    titlesView.frame = CGRectMake(0, 64, self.view.ms_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleButtonW = titlesView.ms_width / count;
    CGFloat titleButtonH = titlesView.ms_height;
    for (NSUInteger i = 0; i < count; i++) {
        // 创建
        MSTitleButton *titleButton = [MSTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:titleButton];
        titleButton.tag = i;
        // 设置数据
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        
        // 设置frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        
        // titleButton.enabled = YES;
        //        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        // titleButton.enabled = NO;
        //        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
    }
    
    // 按钮的选中颜色
    MSTitleButton *lastTitleButton = titlesView.subviews.lastObject;
    NSLog(@"%@", [lastTitleButton titleColorForState:UIControlStateNormal]);
    
    MSTitleButton *firstButton = titlesView.subviews.firstObject;
    
    // 底部的指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [lastTitleButton titleColorForState:UIControlStateSelected];
    indicatorView.ms_height = 1;
    indicatorView.ms_y = titlesView.ms_height - indicatorView.ms_height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    //立即更新indicatorView的frame
    [firstButton.titleLabel sizeToFit];
    indicatorView.ms_width = firstButton.titleLabel.ms_width;
    indicatorView.ms_centerX = firstButton.ms_centerX;
    //默认选中第一个按钮
    firstButton.selected = YES;
    self.selectedTitleButton = firstButton;

}

//按钮的点击
- (void)titleClick:(MSTitleButton *)titleButton {
    // 控制按钮状态
    self.selectedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selectedTitleButton = titleButton;
    
    //    self.selectedTitleButton.enabled = YES;
    //    titleButton.enabled = NO;
    //    self.selectedTitleButton = titleButton;
    
    //    [self.selectedTitleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //    [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    self.selectedTitleButton = titleButton;
    
    // 指示器
    [UIView animateWithDuration:0.25 animations:^{
        // 计算文字宽度
        //        CGFloat titleW = [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width;
        //        CGFloat titleW = [titleButton.currentTitle sizeWithAttributes:@{NSFontAttributeName : titleButton.titleLabel.font}].width;
        //        self.indicatorView.xmg_width = titleW;
        
        self.indicatorView.ms_width = titleButton.titleLabel.ms_width;
        self.indicatorView.ms_centerX = titleButton.ms_centerX;
    }];
    //根据按钮的点击设置scrollView偏移量
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = titleButton.tag * self.scrollView.ms_width;
    [self.scrollView setContentOffset:offset animated:YES];//设置后会调用协议方法

}

- (void)addChildVcView {
    //子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x/self.scrollView.ms_width;
    //根据索引拿到控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) {
        return;
    }//如果控制器已加载，则返回
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

#pragma mark -- UIScrollViewDelegate start --
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //设置按钮的选中
    NSUInteger index = scrollView.contentOffset.x/self.scrollView.ms_width;
    MSTitleButton *selButton = self.titlesView.subviews[index];
    [self titleClick:selButton];
    
    [self addChildVcView];
}
/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildVcView];
}

#pragma mark -- UIScrollViewDelegate end  --

- (void)tagClick {
    MSFunc;
}


@end
