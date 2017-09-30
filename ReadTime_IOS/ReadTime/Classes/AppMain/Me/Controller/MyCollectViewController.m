//
//  MyCollectViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "MyCollectViewController.h"
#import "CommmentAndCollectDataEngine.h"
#import "DetailViewController.h"
#import "Collectinfo.h"
#import "ListCollect.h"
#import "CollectCell.h"

static NSString* CollectCellDentifier=@"CollectCell";
@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray* collects;

@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self header];
    [self footer];
    [self.view addSubview:self.tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"CollectCell" bundle:nil] forCellReuseIdentifier:CollectCellDentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)currentViewDothing{
    [CommmentAndCollectDataEngine control:self userIDinCollect:[UserConfig getUserID] complete:^(id data, NSError *error) {
        if (!error) {
            ListCollect* listColl=[ListCollect mj_objectWithKeyValues:data];
            self.collects=[listColl.results mutableCopy];
            [self.tableview reloadData];
        }
    }];
}

-  (void)disCurrentViewDothing{
    
}
#pragma mark - tableview delegate datasoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectCell* cell=[tableView dequeueReusableCellWithIdentifier:CollectCellDentifier];
    cell.collect=_collects[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Collectinfo* info=self.collects[indexPath.row];
    DetailViewController* detailVC=[[DetailViewController alloc]initWithObjectId:info.desID typeID:info.desTypeID];
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - 属性懒加载
- (UITableView*)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (MJRefreshAutoNormalFooter *)footer{
    if (!_footer) {
        __weak __typeof(self)weakSelf = self;
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong __typeof(self)Strongself = weakSelf;
            [Strongself loadMore];
        }];
        self.tableview.mj_footer = _footer;
    }
    return [self setRefreshAutoNormalFooterParameter:_footer];
}
- (MJRefreshNormalHeader *)header{
    if (!_header) {
        __weak typeof(self)WeakSelf=self;
        _header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong typeof(self)Strongself=WeakSelf;
            [Strongself refresh];
        }];
        self.tableview.mj_header=_header;
    }
    return [self setRefreshNormalHeaderParameter:_header];
}
- (NSMutableArray *)collects{
    if (_collects==nil) {
        _collects=[NSMutableArray new];
    }
    return _collects;
}
#pragma mark - 上下拉加载
- (void)hideLoadMoreRefreshing{
    self.footer.hidden=YES;
}

- (void)showLoadMoreRefreshing{
    self.footer.hidden=NO;
}

- (void)removedRefreshing{
    _header=nil;
    _footer=nil;
    self.tableview.mj_header=nil;
    self.tableview.mj_footer=nil;
}
- (void)endRefreshing{
    if (_header) {
        [self.header endRefreshing];
    }
    if (_footer) {
        [self.footer endRefreshing];
    }
}
- (void)loadMore{
    [self endRefreshing];
    [YJProgressHUD showMessage:@"没有更多" inView:self.view];
}
- (void)refresh{
    [self endRefreshing];
    [YJProgressHUD showMessage:@"已是最新" inView:self.view];
}
@end
