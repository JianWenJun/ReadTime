//
//  BaseViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
@interface BaseViewController : UIViewController

#pragma mark - 公用方法

- (void)requestData;//
- (void)backAction:(UIButton*)sender;//返回
- (void)gotoLoginViewController;//去登陆界面

#pragma mark - 界面切换
//不需要传参数的push 只需告诉类名字符串
- (void)pushViewControllerWithName:(id)className;
//回到当前模块导航下的某一个页面
- (void)returnViewControllerWithName:(id)className;


#pragma mark - 左边按钮定制

/**
 显示默认返回按钮

 @param title 需要传入的上级界面标题
 */
- (void)showBackWithTitle:(NSString*)title;

/**
 自定义左边按钮

 @param icon 图标
 @param title 标题
 @param selector 事件
 */
- (void)setLeftItemWithIcon:(UIImage*)icon title:(NSString*)title selector:(SEL)selector;
- (UIBarButtonItem *)ittemLeftItemWithIcon:(UIImage *)icon title:(NSString *)title selector:(SEL)selector;

#pragma mark -  右边按钮定制

/**
 通过文字设置右侧导航按钮

 @param title 文字
 @param selector 事件
 */
- (void)setRithtItemWithTitle:(NSString*)title selector:(SEL)selector;
- (UIBarButtonItem*)itemRightItemWithTitle:(NSString*)title selector:(SEL)selector;



/**
 通过图标设置右侧导航按钮
 
 @param icon 图标
 @param selector 事件
 */
- (void)setRithtItemWithIcon:(UIImage*)icon selector:(SEL)selector;
- (UIBarButtonItem*)itemRightItemWithIcon:(UIImage*)icon selector:(SEL)selector;

#pragma mark -  titleView定制

//设置纯文字titleVIew
- (void)setNavigationItemTitleViewWithTitle:(NSString *)title;



#pragma mark - MJRefresh刷新
- (MJRefreshNormalHeader *)setRefreshNormalHeaderParameter:(MJRefreshNormalHeader *)header;
- (MJRefreshBackNormalFooter *)setRefreshBackNormalFooterParameter:(MJRefreshBackNormalFooter *)footer;
- (MJRefreshAutoNormalFooter *)setRefreshAutoNormalFooterParameter:(MJRefreshAutoNormalFooter *)footer;
@end
