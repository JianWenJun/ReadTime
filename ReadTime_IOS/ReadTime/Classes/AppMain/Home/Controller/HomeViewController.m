//
//  HomeViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "HomeViewController.h"
#import "SlideViewController.h"
#import "BaseNaViewController.h"
#import "TopicMainViewController.h"
#import "SlideView.h"
#import "SlideArticle.h"
#import "ListSlideArticle.h"
#import "AppDelegate.h"
#import "LArticleDataEngine.h"
#import "HomeArticleDataEngine.h"
#import "HomeListCell.h"
#import "ListArticle.h"
#import "Article.h"
#import "DetailViewController.h"
//
//static NSString* const kStoriesHeaderIdentifier=@"storiesHeader";
//static NSUInteger const kHeaderViewHeight=44;


@interface HomeViewController ()

@property (strong, nonatomic) SlideViewController* sliderViewController;
@property (strong, nonatomic)SlideView* slideView;
@property (strong,nonatomic)ListSlideArticle* arts;
@property (strong,nonatomic)ListArticle* listArticles;
@property (weak,nonatomic)RTBaseDataEngine* headDataEngine;
@property (weak,nonatomic)RTBaseDataEngine* listDataEngine;

@end

@implementation HomeViewController

#pragma mark - init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationItemTitleViewWithTitle:@"首页"];
    [self setRithtItemWithTitle:@"专题" selector:@selector(gotoSpecialTopicView)];
    [self setLeftItemWithIcon:[UIImage imageNamed:@"home_menu"] title:@"" selector:(@selector(gotoMenuView))];
//    [self.tableview registerClass:[HomeListCell class] forCellReuseIdentifier:@"HomeListCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"HomeListCell" bundle:nil] forCellReuseIdentifier:@"HomeListCell"];
    self.tableview.showsVerticalScrollIndicator=NO;
    [YJProgressHUD showProgress:@"加载中..." inView:self.view];
    [self loadHeaderViewData];
    [self loadHomeListData];
}
+ (NSUInteger)sliderDisplayHeight
{
    return 736 == SCREEN_HEIGHT ? 200 : 180;
}
#pragma mark - 生命周期
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.slideView stopSliding];
    [self.headDataEngine cancelRequest];
    [self.listDataEngine cancelRequest];
    AppDelegate *tempAppDelegate = RT_getDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    AppDelegate *tempAppDelegate = RT_getDelegate;
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
    if (_arts!=nil) {
        [self.slideView startSliding];
    }
}
#pragma mark - 懒加载属性
- (SlideViewController*)sliderViewController{
    if (_sliderViewController==nil) {
        _sliderViewController=[[SlideViewController alloc]initWithFrame:CGRectMake(0, 0,
                                                                                   self.view.bounds.size.width,
                                                                                   [self.class sliderDisplayHeight])
    andArt:self.arts.results];
    }
    return _sliderViewController;
}
- (SlideView*)slideView{
    if (_slideView==nil) {
        _slideView=self.sliderViewController.sliderView;
    }
    return _slideView;
}
#pragma mark - 数据加载
//- (NSArray *)cellDataSource{
//    if (!self.dataSource) {
//        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:1];//多少节
//        NSMutableArray *subarr = nil;//每节多少行
//        __block NSDictionary * dict = nil;//行
//        if (_listArticles==nil) {
//            [self showLoadMoreRefreshing];
//            return self.dataSource;
//        }
//        subarr=[NSMutableArray arrayWithCapacity:_listArticles.results.count];
//        [self.listArticles.results enumerateObjectsUsingBlock:^(Article* obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           dict=@{
//                   @"class":HomeListCell.class,
//                   @"delegate":@(YES),
//                   @"data":obj
//                   };
//            [subarr addObject:dict];
//        }];
//        [arr addObject:subarr];
//    }
//    return self.dataSource;
//}
- (void)loadHomeListData{
    _listDataEngine=[HomeArticleDataEngine control:self skip:1 complete:^(id data, NSError *error) {
                if (error) {
                    NSLog(@"error:%@",error.localizedDescription);
                } else {
                    _listArticles=[ListArticle mj_objectWithKeyValues:data];
                    [self setData:_listArticles];
                    [self.tableview reloadData];
                    [self showLoadMoreRefreshing];
                    [YJProgressHUD hide];
                }
            }];
}
- (void)loadHeaderViewData{
    _headDataEngine=[LArticleDataEngine control:self complete:^(id data, NSError *error) {
        if (error) {
            [YJProgressHUD showMessage:error.localizedDescription inView:self.view];
//            NSLog(@"error:%@",error.localizedDescription);
        } else {
            _arts=[ListSlideArticle mj_objectWithKeyValues:data];
            [self buildSliderView];
            [YJProgressHUD hide];
        }
    }];
}
- (void)buildSliderView{
   [self addChildViewController:self.sliderViewController];
//   [self.view addSubview:self.sliderViewController.view];
    //tabview添加头部
    self.tableview.tableHeaderView=self.sliderViewController.view;
//    [self.tableview.tableHeaderView setTranslatesAutoresizingMaskIntoConstraints:NO];
}
#pragma mark - 视图切换

/**
 切换至专题模块
 */
- (void)gotoSpecialTopicView{   
    BaseNaViewController* nTopicVc=[[BaseNaViewController alloc]initWithRootViewController:[[TopicMainViewController alloc]init]];
     nTopicVc.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
    [self presentViewController:nTopicVc animated:YES completion:nil];
}

/**
 切换至侧滑菜单
 */
- (void)gotoMenuView{
    AppDelegate *tempAppDelegate = RT_getDelegate;
    if (tempAppDelegate.LeftSlideVC.closed) {
//        [self.slideView stopSliding];
        [tempAppDelegate.LeftSlideVC openLeftView];
    }else{
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)gotoListDetailVC:(NSDictionary*)cellData{
        if ([cellData[@"data"] isKindOfClass:[Article class]]) {
            Article* art=cellData[@"data"];
//            NSString* artContent=art.articleHeader;
//            [YJProgressHUD showMessage:artContent inView:self.view];
            DetailViewController* detailVC=[[DetailViewController alloc]initWithObjectId:art.objectId typeID:1];
            detailVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
   

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
               @"class":@"HomeListCell",
               @"delegate":@(YES),
               @"data":obj,
               @"action":@"gotoListDetailVC:"
               };
        [subarr addObject:dict];
    }];
    [arr addObject:subarr];
    self.dataSource=arr;
}



@end
