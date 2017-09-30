//
//  BaseTabViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"  
@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView* tableview;
@property (strong,nonatomic)NSArray* dataSource;

- (NSArray *)cellDataSource;

#pragma mark - 上下拉加载
- (void)removedRefreshing;//去掉上下拉刷新 列表默认添加 如不需要可调用该方法移除
- (void)refresh;//下拉请求
- (void)loadMore;//加载更多
- (void)endRefreshing;//结束刷新
- (void)hideLoadMoreRefreshing;//隐藏加载更多
- (void)showLoadMoreRefreshing;//显示加载更多

#pragma mark - 返回顶部
- (void)showBackToTopBtn;//显示返回顶部按钮
- (void)hideBackToTopBtn;//隐藏返回顶部按钮
#pragma mark - 单section数据的设置添加删除

//刷新数据
- (void)refreshData;
@end
