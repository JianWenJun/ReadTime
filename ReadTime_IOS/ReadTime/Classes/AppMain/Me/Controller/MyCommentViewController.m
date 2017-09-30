//
//  MyCommentViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "MyCommentViewController.h"
#import "CommentCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Comment.h"
#import "ListComment.h"
#import "CommmentAndCollectDataEngine.h"
#import "CKAlertViewController.h"
static NSString* CommentCellDentifier=@"CommentCell";
@interface MyCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray* commments;

@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self header];
    [self footer];
    [self.view addSubview:self.tableview];
    [self.tableview registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil] forCellReuseIdentifier:CommentCellDentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)currentViewDothing{
    [CommmentAndCollectDataEngine control:self userIDinComment:[UserConfig getUserID] complete:^(id data, NSError *error) {
        if (!error) {
            ListComment* listComment=[ListComment mj_objectWithKeyValues:data];
            self.commments=[listComment.results mutableCopy];
            [self.tableview reloadData];
        }
    }];
}

- (void)disCurrentViewDothing{
    
}
#pragma mark - tableview delegate datasoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell* cell=[tableView dequeueReusableCellWithIdentifier:CommentCellDentifier];
    cell.commentM=self.commments[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.commments.count>0) {
        return  [tableView fd_heightForCellWithIdentifier:CommentCellDentifier configuration:^(CommentCell* cell) {
            cell.commentM=self.commments[indexPath.row];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }];
    }else{
        return 0;
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Comment* comment=self.commments[indexPath.row];
    [self deleteComment:comment];
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
- (NSMutableArray *)commments{
    if (_commments==nil) {
        _commments=[NSMutableArray new];
    }
    return _commments;
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
#pragma mark - 内部方法
- (void)deleteComment:(Comment*)comment{
    CKAlertViewController *alertVC = [CKAlertViewController alertControllerWithTitle:@"删除评论" message:@"您确定要删除该评论?" ];
    CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
    }];
    CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确定" handler:^(CKAlertAction *action) {
        [CommmentAndCollectDataEngine control:self objectIDinCommentCancel:comment.objectId complete:^(id data, NSError *error) {
            if (!error) {
                [self.commments removeObject:comment];
                [self.tableview reloadData];
                [YJProgressHUD showMessage:@"删除成功" inView:self.view];
            }
        }];
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:sure];
    [self presentViewController:alertVC animated:NO completion:nil];
}

@end
