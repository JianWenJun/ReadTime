//
//  CollAndUpMainViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "CollAndUpMainViewController.h"
#import "MyUpViewController.h"
#import "MyCollectViewController.h"
#import "MyCommentViewController.h"
#import "TitleBarView.h"

@interface CollAndUpMainViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSArray* controllers;//包含的3个专题的VC
@property (nonatomic,strong)NSArray* titles;//
@property (nonatomic,weak)TitleBarView* titleBar;
@property (nonatomic,strong)UIScrollView* scrollView;


@end

@implementation CollAndUpMainViewController
- (instancetype)init{
    self=[super init];
    if (self) {
        MyCollectViewController *McVC=[[MyCollectViewController alloc]init];
        MyUpViewController *MuVC=[[MyUpViewController alloc]init];
        MyCommentViewController *McvVC=[[MyCommentViewController alloc]init];
        _titles=@[@"我的收藏",@"我的发布",@"我的评论"];
        _controllers=@[McVC,MuVC,McvVC];
        for (UIViewController* vc in _controllers) {
            [self addChildViewController:vc];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"我的相关"];
    [self showBackWithTitle:@"返回"];
    [self addView]; 
    [self.titleBar scrollToCenterWithIndex:_selectIndex];
    [_controllers[_selectIndex] currentViewDothing];
    [_scrollView setContentOffset:CGPointMake(SCREEN_SIZE.width * _selectIndex, 0) animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.translucent = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)addView{
    TitleBarView* titleBar=[[TitleBarView alloc]initWithFrame:CGRectMake(0,64, SCREEN_SIZE.width, 36) andTitles:_titles andNeedScroll:NO];
    titleBar.backgroundColor=UIColorFromHex(0xe5e5e5);
    titleBar.titleButtonClicked=^(NSUInteger index){
        [_controllers[index] currentViewDothing];
        [_scrollView setContentOffset:CGPointMake(SCREEN_SIZE.width * index, 0) animated:YES];
    };
    _titleBar=titleBar;
    [self.view addSubview:_titleBar];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleBar.frame), SCREEN_SIZE.width, SCREEN_SIZE.height)];
    scrollView.contentSize = CGSizeMake(SCREEN_SIZE.width * _controllers.count, 0);
    scrollView.pagingEnabled=YES;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView = scrollView;
    [self.view addSubview:_scrollView];
    for (UIViewController* vc in _controllers) {
        NSInteger index = [_controllers indexOfObject:vc];
        vc.view.frame = CGRectMake(SCREEN_SIZE.width * index, 0, SCREEN_SIZE.width, CGRectGetHeight(_scrollView.frame));
        [_scrollView addSubview:vc.view];
    }
}

#pragma mark - 点击事件
- (void)backAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    for (NSInteger i=0;i<_controllers.count;i++ ){
        [_controllers[i] disCurrentViewDothing];//请求取消
    }
}

#pragma mark - method

/**
 进入时刷新当前页面
 */
- (void)refreshCurrentViewCOntroller{
    
}
#pragma mark - UIScrollVIewDelegate
//减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/SCREEN_SIZE.width;
    [self.titleBar scrollToCenterWithIndex:index];
}
@end
