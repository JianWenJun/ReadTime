//
//  SlideViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "SlideViewController.h"
#import "HomeViewController.h"
#import "SlideView.h"
#import "SlideArticle.h"
#import "DetailViewController.h"
@interface SlideViewController ()<SlideViewDataSource>

@property (strong,nonatomic)NSArray<SlideArticle*>* slideArticles;
@property (assign,nonatomic)BOOL isAnimating;

@end

@implementation SlideViewController
#pragma mark - initialization
- (instancetype)initWithFrame:(CGRect)frame andArt:(NSArray *)slideArticles{
    self=[super init];
    if (self) {
        self.slideArticles=[slideArticles copy];
        self.sliderView=[[SlideView alloc]initWithFrame:frame];
        [self buildSliderView];
    }
    return self;
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
//    SlideArticle* sli=[_slideArticles objectAtIndex:0];
//    NSLog(@"url:%@",sli.imgUrl);
//    [imageView loadPortrait:[NSURL URLWithString:sli.imgUrl]];
//    [self.view addSubview:imageView];
//    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - 内部私有方法
- (void)buildSliderView{
    self.sliderView.dataSource=self;
//    self.sliderView.contentInsetY=[HomeViewController sliderInsetY];
    self.view=self.sliderView;
    
    [self.sliderView buildSliderView];
    [self loadSliderViewImages];
}
- (void)loadSliderViewImages{
//    加载图片
    [self.slideArticles enumerateObjectsUsingBlock:^(SlideArticle * _Nonnull slid, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURL* url=[NSURL URLWithString:slid.imgUrl];
        [self.sliderView setImageURL:url atIndex:idx];
    }];
    
    
}
#pragma mark - SlideViewDataSource方法的实现
- (NSInteger)numberOfItemsInSliderView{
    return self.slideArticles.count;
}
- (NSString*)titleForSliderAtIndex:(NSInteger)index{
    return self.slideArticles[index].imgTitle;
}
#pragma mark - 视图切换
//点击事件
- (void)touchUpForSliderAtIndex:(NSInteger)index{
    if (self.isAnimating)
        return;
    SlideArticle* selectArt=_slideArticles[index];
    DetailViewController* detailVC=[[DetailViewController alloc]initWithObjectId:selectArt.objectId typeID:3];
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];    
}
#pragma mark release
- (void)dealloc{
    [self removeFromParentViewController];
}
@end
