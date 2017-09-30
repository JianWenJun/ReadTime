//
//  XinLinViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/9.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "XinLinViewController.h"
#import "SpecialArticleDataEngine.h"
#import "ListArticle.h"
#import "Article.h"
#import "DetailViewController.h"
@interface XinLinViewController ()

@property(weak,nonatomic)RTBaseDataEngine* listDataEngine;
@property (strong,nonatomic)ListArticle* listArticles;

@end

@implementation XinLinViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableview registerNib:[UINib nibWithNibName:@"XinLinCell" bundle:nil] forCellReuseIdentifier:@"XinLinCell"];
    self.tableview.showsVerticalScrollIndicator=NO;
    [self showLoadMoreRefreshing];
   
}

- (void)currentViewDothing{
    if (!_listArticles) {
        [YJProgressHUD showProgress:@"加载中..." inView:self.view];
        [self loadListData];
        NSLog(@"XinLinViewController--doing");
    }
    
}
- (void)disCurrentViewDothing{
    [_listDataEngine cancelRequest];
    NSLog(@"XinLinViewController--undoing");
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//     NSLog(@"XINviewDidDisappear");
    [YJProgressHUD hide];
    [_listDataEngine cancelRequest];
}
- (void)dealloc{
    
     }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据加载
- (void)loadListData{
    [SpecialArticleDataEngine control:self skip:1 typeID:6 complete:^(id data, NSError *error) {
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
#pragma mark -每行数据的添加
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
               @"class":@"XinLinCell",
               @"delegate":@(YES),
               @"data":obj,
               @"action":@"gotoListDetailVC:"
               };
        [subarr addObject:dict];
    }];
    [arr addObject:subarr];
    self.dataSource=arr;
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
