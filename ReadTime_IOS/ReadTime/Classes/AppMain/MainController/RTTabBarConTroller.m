//
//  RTTabBarConTroller.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTTabBarConTroller.h"
#import "RTTabBar.h"
#import "HomeViewController.h"
//#import "UpimageViewController.h"
#import "UpArticleViewController.h"
#import "BeaImgViewController.h"
#import "UIImageView+ImageViewCorner.h"
#import "BaseNaViewController.h"
@interface RTTabBarConTroller ()<RTTabBarDelegate>


@end

@implementation RTTabBarConTroller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 初始化操作
/**
 初始化底部tab
 */
- (void)initTabBar{
    self.view.backgroundColor=[UIColor grayColor];//设置为灰色
    BaseNaViewController* nhomeVc=[[BaseNaViewController alloc]initWithRootViewController:[HomeViewController new]];
    BaseNaViewController* nbeaImgVc=[[BaseNaViewController alloc]initWithRootViewController:[BeaImgViewController new]];
    self.viewControllers=@[nhomeVc,nbeaImgVc];
    //设置UITabBar显示的背景和
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    
    RTTabBar *tabBar=[[RTTabBar alloc]initWithFrame:self.tabBar.bounds];
    tabBar.tabBarItemAttributes= @[@{RTTabBarItemAttributeTitle : @"首页", RTTabBarItemAttributeNormalImageName : @"home_normal", RTTabBarItemAttributeSelectedImageName : @"home_highlight", RTTabBarItemAttributeType : @(RTTabBarItemNormal)},
                                   @{RTTabBarItemAttributeTitle : @"发布", RTTabBarItemAttributeNormalImageName : @"post_normal", RTTabBarItemAttributeSelectedImageName : @"post_normal", RTTabBarItemAttributeType : @(RTTabBarItemRise)},
                                   @{RTTabBarItemAttributeTitle : @"美图", RTTabBarItemAttributeNormalImageName : @"beaimg_normal", RTTabBarItemAttributeSelectedImageName : @"beaimg_highlight", RTTabBarItemAttributeType : @(RTTabBarItemNormal)},
                                   ];
    tabBar.delegate=self;
    [self.tabBar addSubview:tabBar];
}

#pragma mark - 手势事件


- (void) goToOtherController: (NSUInteger)type{
    switch (type) {
            
        case 1:{
            UpArticleViewController *UaVc=[[UpArticleViewController alloc]init];
            BaseNaViewController* nUaVc=[[BaseNaViewController alloc]initWithRootViewController:UaVc];
            [self presentViewController:nUaVc animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 实现代理的方法

/**
 处理中间ActionSheet点击事件
 */
- (void)tabBarDidSelectedRiseButton{
    if ([UserConfig IsLogin]) {
        UIAlertController *Uac=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *upArt=[UIAlertAction actionWithTitle:@"上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self goToOtherController:1];
        }];
        UIAlertAction *cancal=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [Uac addAction:upArt];
        [Uac addAction:cancal];
        [self presentViewController:Uac animated:YES completion:nil];
    }else{
        [YJProgressHUD showMessage:@"请先登录" inView:self.view];
    }   
}

@end
