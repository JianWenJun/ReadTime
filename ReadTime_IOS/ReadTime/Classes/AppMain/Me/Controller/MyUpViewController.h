//
//  MyUpViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseViewController.h"

@interface MyUpViewController : BaseViewController

@property (nonatomic,strong)UITableView* tableview;
@property (nonatomic,strong) MJRefreshNormalHeader *header;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;


#pragma mark - 上下拉加载
- (void)removedRefreshing;//去掉上下拉刷新 列表默认添加 如不需要可调用该方法移除
- (void)refresh;//下拉请求
- (void)loadMore;//加载更多
- (void)endRefreshing;//结束刷新
- (void)hideLoadMoreRefreshing;//隐藏加载更多
- (void)showLoadMoreRefreshing;//显示加载更多
#pragma mark - 卡片切换
- (void)currentViewDothing;
- (void)disCurrentViewDothing;
@end
