//
//  BaseTabViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewCell.h"

@interface BaseTableViewController ()
@property (nonatomic,strong) MJRefreshNormalHeader *header;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong) UIButton *backToTopBtn;//返回顶部按钮
@property(nonatomic,assign)  NSInteger pageIndex;
@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self header];//设置刷新头
    [self footer];
    [self.view addSubview:self.tableview];
    [self hideLoadMoreRefreshing];
//    self.tableview.fd_debugLogEnabled=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   }


#pragma mark - set/get
- (MJRefreshNormalHeader*)header{
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
- (MJRefreshAutoNormalFooter*)footer{
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

- (NSArray*)cellDataSource{
    return self.dataSource;
}
#pragma mark - 内部私有方法
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
- (void)showBackToTopBtn{
    if (nil==_backToTopBtn) {
        _backToTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 36 - 20, self.view.frame.size.height - 20 - 36, 36, 36)];
        [_backToTopBtn setBackgroundImage:[UIImage imageNamed:@"back_to_top"] forState:UIControlStateNormal];
        [_backToTopBtn addTarget:self action:@selector(onBackToTopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backToTopBtn];
    }
}
- (void)hideBackToTopBtn{
    [UIView animateWithDuration:0.3 animations:^{
        _backToTopBtn.alpha=0.0;
    }];
}
- (void)onBackToTopBtnClick{
    [self.tableview setContentOffset:CGPointMake(0,-self.tableview.contentInset.top)animated:YES];
}


/**
 刷新tableview
 */
- (void)refreshData{
    self.dataSource=nil;
    [self.tableview reloadData];
}
#pragma mark - 对外提供的方法
- (void)loadMore{
    self.pageIndex++;
    [self requestData];
}
- (void)refresh{
    self.pageIndex=1;
    [self requestData];
    [YJProgressHUD showMessage:@"已是最新" inView:self.view];
}

- (void)requestData {
    [self endRefreshing];
}
#pragma mark - tableview delegate和datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.cellDataSource.count > 0) {
        return self.cellDataSource.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.cellDataSource.count > 0) {
        id obj = self.cellDataSource[section];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray *)obj;
            return [arr count];
        }
        return 1;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellDict=[self getCellDictFromSourceData:indexPath];
    if (cellDict!=nil) {
        NSNumber* delFlag=cellDict[@"delegate"];
        NSString* ident=cellDict[@"class"];
        BaseTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell) {
            cell = [[BaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:(NSString*)ident];
        }
        [self configCell:cell andIndexPaht:indexPath andData:cellDict andDelegete:delFlag];
        return cell;
    }else{
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        }
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *cellDict=[self getCellDictFromSourceData:indexPath];
    NSString* defaultIdentifier=@"CellID";
    NSNumber* delFlag=@(NO);
    if (cellDict!=nil) {
        defaultIdentifier=cellDict[@"class"];
        delFlag=cellDict[@"delegate"];
    }
    
    CGFloat height=[tableView fd_heightForCellWithIdentifier:defaultIdentifier cacheByIndexPath:indexPath configuration:^(BaseTableViewCell *cell){
        [self configCell:cell andIndexPaht:indexPath andData:cellDict andDelegete:delFlag];
    }];
    return height;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *cellDict=[self getCellDictFromSourceData:indexPath];
    if (cellDict!=nil) {
        NSString *actiongStr = cellDict[@"action"];
        if (actiongStr.length>0) {
            SEL action=NSSelectorFromString(actiongStr);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:action withObject:cellDict];
#pragma clang diagnostic pop
        };
    }
    [self.view endEditing:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)configCell:(BaseTableViewCell*)cell andIndexPaht:(NSIndexPath*)indexPath andData:(NSDictionary*)data andDelegete:(NSNumber*)delFlag{
    NSInteger num=1;
    if (self.cellDataSource.count > 0){
        id obj = self.cellDataSource[indexPath.section];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray* section=(NSArray*)obj;
            num=section.count;
        }
    }
    [cell setSeperatorLineForIOS7:indexPath numberOfRowsInSection:num];
    id delegate = nil;
    if (delFlag && delFlag.boolValue) {
        delegate = self;
    }
    [cell setData:data delegate:delegate];
}

/**
   获取cell对应的数据
 */
- (NSDictionary *)getCellDictFromSourceData:(NSIndexPath*)indexPath{
    NSDictionary* cellDict=nil;
    if (self.cellDataSource.count > 0){
        id obj = self.cellDataSource[indexPath.section];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray* section=(NSArray*)obj;
            id dicObj = section[indexPath.row];
            if ([dicObj isKindOfClass:[NSDictionary class]]) {
                cellDict = (NSDictionary *)dicObj;
            }
        }
    }
    return cellDict;
}

@end
