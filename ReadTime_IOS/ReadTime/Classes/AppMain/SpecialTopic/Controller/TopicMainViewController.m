//
//  TopicMainViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "TopicMainViewController.h"
#import "XinLinViewController.h"
#import "ChengZhangViewController.h"
#import "WenYiViewController.h"
#import "TitleBarView.h"

@interface TopicMainViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSArray* controllers;//包含的3个专题的VC
@property (nonatomic,strong)NSArray* titles;//
@property (nonatomic,weak)TitleBarView* titleBar;
@property (nonatomic,assign)UIScrollView* scrollView;


@end

@implementation TopicMainViewController

- (instancetype)init{
    self=[super init];
    if (self) {
        XinLinViewController *XLVC=[[XinLinViewController alloc]init];
        ChengZhangViewController *CZVC=[[ChengZhangViewController alloc]init];
        WenYiViewController *WYVC=[[WenYiViewController alloc]init];
        _titles=@[@"心灵启迪",@"成长点滴",@"文艺范"];
        _controllers=@[XLVC,CZVC,WYVC];
        for (UIViewController* vc in _controllers) {
            [self addChildViewController:vc];
        }
    }
    return self;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"专题"];
    [self showBackWithTitle:@"返回"];
    [self addView];
    [_controllers[0] currentViewDothing];
}
- (void)addView{
    TitleBarView* titleBar=[[TitleBarView alloc]initWithFrame:CGRectMake(0,64, SCREEN_SIZE.width, 36) andTitles:_titles andNeedScroll:NO];
    titleBar.backgroundColor=UIColorFromHex(0xe5e5e5);
    titleBar.titleButtonClicked=^(NSUInteger index){
        [_scrollView setContentOffset:CGPointMake(SCREEN_SIZE.width * index, 0) animated:YES];
        [_controllers[index] currentViewDothing];
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
