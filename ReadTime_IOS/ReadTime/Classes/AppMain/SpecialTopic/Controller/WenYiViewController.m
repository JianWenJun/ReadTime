//
//  WenYiViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "WenYiViewController.h"
#import "DetailViewController.h"
#import "SpecialArticleDataEngine.h"
#import "ListArticle.h"
#import "Article.h"

@interface WenYiViewController ()

@property(weak,nonatomic)RTBaseDataEngine* listDataEngine;
@property (strong,nonatomic)ListArticle* listArticles;

@end

@implementation WenYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview registerNib:[UINib nibWithNibName:@"LvXingCell" bundle:nil] forCellReuseIdentifier:@"LvXingCell"];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self showLoadMoreRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 数据加载
- (void)loadListData{
    [SpecialArticleDataEngine control:self skip:1 typeID:8 complete:^(id data, NSError *error) {
        if (error) {
            NSLog(@"error:%@",error.localizedDescription);
        }else{
            _listArticles=[ListArticle mj_objectWithKeyValues:data];
            [self setData:_listArticles];
            [self.tableview reloadData];
            [self showLoadMoreRefreshing];
            [YJProgressHUD hide];
        }
    }];
}

- (void)setData:(ListArticle*)arrys{
    self.dataSource=nil;
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];//多少节
    NSMutableArray *subarr = nil;//每节多少行
    __block NSDictionary * dict = nil;//行
    if (arrys.results.count==0) {
        [self showLoadMoreRefreshing];
        return;
    }
    subarr=[NSMutableArray arrayWithCapacity:arrys.results.count];
    [arrys.results enumerateObjectsUsingBlock:^(Article* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dict=@{
               @"class":@"LvXingCell",
               @"delegate":@(YES),
               @"data":obj,
               @"action":@"gotoListDetailVC:"
               };
        [subarr addObject:dict];
    }];
    [arr addObject:subarr];
    self.dataSource=arr;
}
#pragma mark -   VC可见/不可见情况的操作
- (void)currentViewDothing{
    if (!_listArticles) {
        [YJProgressHUD showProgress:@"加载中..." inView:self.view];
        [self loadListData];
    }
    NSLog(@"WenYiViewController--doing");
}
- (void)disCurrentViewDothing{
    NSLog(@"WenYiViewController--undoing");
    [_listDataEngine cancelRequest];
}

#pragma mark - 视图切换
- (void)gotoListDetailVC:(NSDictionary*)cellData{
    if ([cellData[@"data"] isKindOfClass:[Article class]]) {
        Article* art=cellData[@"data"];
        DetailViewController* detailVC=[[DetailViewController alloc]initWithObjectId:art.objectId typeID:1 isZti:YES];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}
@end
