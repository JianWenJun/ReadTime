//
//  BaseViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"
#import "NSString+Extension.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showBack];
    [self requestData];
    self.view.backgroundColor=ViewBackgroundColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.view endEditing:YES];
}
#pragma mark - 公共方法--视图切换
- (void)pushViewControllerWithName:(id)className{
    if (className) {
        Class class;
        if ([className isKindOfClass:[NSString class]]) {
            NSString* name=className;
            class=NSClassFromString(name);
        }else if ([className isSubclassOfClass:[BaseViewController class]]){
            class=className;
        }
        UIViewController* vc=[class new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)returnViewControllerWithName:(id)className{
    if (className) {
        Class classs;
        if ([className isKindOfClass:[NSString class]]) {
            NSString *name = className;
            classs = NSClassFromString(name);
        } else if ([className isSubclassOfClass:[BaseViewController class]]) {
            classs = className;
        }
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:classs]) {
                [self.navigationController popToViewController:obj animated:YES];
                *stop=YES;
                return ;
            }
        }];
    }

}
#pragma mark - 公共方法--导航条的设置
//纯文字
- (void)setNavigationItemTitleViewWithTitle:(NSString *)title{
    self.navigationItem.titleView=nil;
    if (title.length==0) {
        return;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateNormal];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    float leight = titleSize.width;
    [btn setFrame:CGRectMake(0, 0, leight, 30)];
    self.navigationItem.titleView = btn;
}
//左边
- (void)showBackWithTitle:(NSString *)title{
    NSString* imageName=@"back_more_nor";
    if (StatusBarStyle==UIStatusBarStyleLightContent) {
        imageName=@"back_more";
    }
    [self setLeftItemWithIcon:[UIImage imageNamed:imageName] title:title selector:@selector(backAction:)];
}
- (void)setLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector{
    self.navigationItem.leftBarButtonItem=[self ittemLeftItemWithIcon:icon title:title selector:selector];
}

- (UIBarButtonItem*)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector{
    UIBarButtonItem* item;
    if (!icon&&title.length==0) {
        item=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        return item;
    }
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateNormal];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    float leight = titleSize.width;
    if (icon) {
        leight += icon.size.width;
        [btn setImage:icon forState:UIControlStateNormal];
        [btn setImage:icon forState:UIControlStateHighlighted];
        if (title.length == 0) {
            //文字没有的话，点击区域+10
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -13, 0, 13);
        } else {
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 3);
        }
    }
    if (title.length == 0) {
        //文字没有的话，点击区域+10
        leight = leight + 10;
    }
    view.frame = CGRectMake(0, 0, leight, 30);
    btn.frame = CGRectMake(-5, 0, leight, 30);
    [view addSubview:btn];
    
    item = [[UIBarButtonItem alloc] initWithCustomView:view];
    return item;
}
//右边
- (void)setRithtItemWithTitle:(NSString *)title selector:(SEL)selector{
    UIBarButtonItem* item=[self itemRightItemWithTitle:title selector:selector];
    self.navigationItem.rightBarButtonItem=item;
}

- (void)setRithtItemWithIcon:(UIImage *)icon selector:(SEL)selector{
    UIBarButtonItem* item=[self itemRightItemWithIcon:icon selector:selector];
    self.navigationItem.rightBarButtonItem=item;
}

- (UIBarButtonItem*)itemRightItemWithTitle:(NSString *)title selector:(SEL)selector{
    UIBarButtonItem* item;
    if (title.length==0) {
        item=[[UIBarButtonItem new]initWithCustomView:[UIView new]];
        return item;
    }
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor clearColor];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateNormal];
    [btn setTitleColor:UIToneTextColor forState:UIControlStateHighlighted];
    CGSize titleSize = [title ex_sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)];
    float leight = titleSize.width;
    [btn setFrame:CGRectMake(0, 0, leight, 30)];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (UIBarButtonItem*)itemRightItemWithIcon:(UIImage *)icon selector:(SEL)selector{
    UIBarButtonItem *item;
    if (!icon) {
        item = [[UIBarButtonItem new] initWithCustomView:[UIView new]];
        return item;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    if (selector) {
        [btn addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    float leight = icon.size.width;
    [btn setImage:icon forState:UIControlStateNormal];
    [btn setImage:icon forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [btn setFrame:CGRectMake(0, 0, leight, 30)];
    
    item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}
#pragma mark - 下拉刷新提供的方法
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header {
    //header.lastUpdatedTimeLabel.hidden = YES;
    
    //[header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderIdleText", @"MJRefresh", @"下拉可以刷新") forState:MJRefreshStateIdle];
    //[header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderPullingText", @"MJRefresh", @"松开立即刷新") forState:MJRefreshStatePulling];
    //[header setTitle:NSLocalizedStringFromTable(@"MJRefreshHeaderRefreshingText", @"MJRefresh",@"正在刷新数据中...") forState:MJRefreshStateRefreshing];
    return header;
}

- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer {
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterIdleText", @"MJRefresh",@"上拉可以加载更多") forState:MJRefreshStateIdle];
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterPullingText", @"MJRefresh",@"松开立即加载更多") forState:MJRefreshStatePulling];
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterRefreshingText", @"MJRefresh",@"正在加载更多的数据...") forState:MJRefreshStateRefreshing];
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshBackFooterNoMoreDataText", @"MJRefresh",@"已经全部加载完毕") forState:MJRefreshStateNoMoreData];
    return footer;
}

- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer {
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterIdleText", @"MJRefresh",@"点击或上拉加载更多") forState:MJRefreshStateIdle];
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterRefreshingText", @"MJRefresh",@"正在加载更多的数据...") forState:MJRefreshStateRefreshing];
    //[footer setTitle:NSLocalizedStringFromTable(@"MJRefreshAutoFooterNoMoreDataText", @"MJRefresh",@"已经全部加载完毕") forState:MJRefreshStateNoMoreData];
    return footer;
}

#pragma mark - (私有方法)
- (void)showBack{
    if (self.navigationController.viewControllers.count>1) {
        UIViewController* vc=self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        if (vc.title.length>0) {
            [self showBackWithTitle:vc.title];
        }else{
            [self showBackWithTitle:vc.navigationItem.title];
        }
    }
}
//点击空白地方收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark - 子类需要复写的方法
- (void)requestData{
    
}
- (void)gotoLoginViewController{
    
}
//返回
- (void)backAction:(UIButton *)sender {
//    [self returnViewControllerWithName:@"HXPhotosViewController"];
}


@end
