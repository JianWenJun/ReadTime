//
//  BaseCollectionViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//瀑布流
#import "BaseViewController.h"
#import "WaterFallCollectionLayout.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataAry;
@property(nonatomic,strong)WaterFallCollectionLayout* layout;

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

@end
