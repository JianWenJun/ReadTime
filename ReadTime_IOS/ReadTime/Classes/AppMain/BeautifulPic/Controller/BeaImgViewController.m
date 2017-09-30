//
//  BeaImgViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BeaImgViewController.h"
#import "BaseNaViewController.h"
#import "TopicMainViewController.h"
#import "AppDelegate.h"
#import "ListImgArt.h"
#import "ImgBea.h"
#import "ImgBeaDataEngine.h"

@interface BeaImgViewController ()

@property (strong,nonatomic)ListImgArt* listImg;
@property (weak,nonatomic)RTBaseDataEngine* imgDataEngine;

@end

@implementation BeaImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"美图"];
    [self setRithtItemWithTitle:@"专题" selector:@selector(gotoSpecialTopicView)];
    [self setLeftItemWithIcon:[UIImage imageNamed:@"home_menu"] title:@"" selector:(@selector(gotoMenuView))];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImgBeaCell" bundle:nil] forCellWithReuseIdentifier:@"ImgBeaCell"];
    self.collectionView.showsVerticalScrollIndicator=NO;
    [YJProgressHUD showProgress:@"加载中..." inView:self.view];
    [self loadImgData];
}

#pragma mark - 生命周期
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate *tempAppDelegate = RT_getDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self showLoadMoreRefreshing];
    AppDelegate *tempAppDelegate = RT_getDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}
#pragma mark -数据加载
- (void)loadImgData{
    [ImgBeaDataEngine control:self skip:1  complete:^(id data, NSError *error) {
        if (error) {
            [YJProgressHUD showMessage:error.localizedDescription inView:self.view];
        }else{
//            NSLog(@"data%@",data);
            _listImg=[ListImgArt mj_objectWithKeyValues:data];
            self.dataAry=_listImg.results;
            [self.collectionView reloadData];
            [YJProgressHUD hide];
            
        }
    }];
}
#pragma mark - 视图切换
/**
 切换至侧滑菜单
 */
- (void)gotoMenuView{
    AppDelegate *tempAppDelegate = RT_getDelegate;
    if (tempAppDelegate.LeftSlideVC.closed) {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }else{
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}
/**
 切换至专题模块
 */
- (void)gotoSpecialTopicView{
    
    BaseNaViewController* nTopicVc=[[BaseNaViewController alloc]initWithRootViewController:[[TopicMainViewController alloc]init]];
    nTopicVc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:nTopicVc animated:YES completion:nil];
}

@end
