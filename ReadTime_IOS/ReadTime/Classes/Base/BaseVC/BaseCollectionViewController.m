//
// BaseCollectionViewController.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "DetailViewController.h"
#import "ImgBeaCell.h"
#import "UIImageView+WebCache.h"
#import "XHWebImageAutoSize.h"
#import "ImgBea.h"
#import "PYPhotoBrowseView.h"
@interface BaseCollectionViewController ()

@property (nonatomic,strong) MJRefreshNormalHeader *header;
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
@property (nonatomic,strong) UIButton *backToTopBtn;//返回顶部按钮
@property (nonatomic,assign) NSInteger pageIndex;


@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self header];
    [self footer];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 网络请求

- (void)requestData {
    [self endRefreshing];
}

#pragma mark - 代理
#pragma mark UICollectionViewDataSource/UICollectionViewDelegate
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataAry.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"ImgBeaCell";
    ImgBeaCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    ImgBea* beaImg=self.dataAry[indexPath.item];
    NSString* url=beaImg.imgUrl;
    [cell.showImg setIsRound:NO withSize:CGSizeZero];
    [cell.showImg sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        /**
         *  缓存imageSize
         */
        [XHWebImageAutoSize storeImageSize:image forURL:imageURL completed:^(BOOL result) {
            if (result) {
                [collectionView xh_reloadItemAtIndexPath:indexPath forURL:imageURL];
            }
        }];
    }];
    cell.imgDes.text=beaImg.imgDes;
    UILongPressGestureRecognizer* longgs=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
    [cell addGestureRecognizer:longgs];//为cell添加手势
    longgs.minimumPressDuration=1.0;//定义长按识别时长
    longgs.view.tag=indexPath.row;//将手势和位置绑定
    return cell;
}
- (void)longpress:(UILongPressGestureRecognizer*)longgs{
    if (longgs.state==UIGestureRecognizerStateBegan) {
        //获取目标cell
        NSInteger row=longgs.view.tag;
        ImgBea* beaImg=self.dataAry[row];
        NSString* url=beaImg.imgUrl;
        PYPhotoBrowseView* browView=[[PYPhotoBrowseView alloc]init];
        browView.imagesURL=[NSArray arrayWithObject:url];
        [browView show];
    }
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgBea* beaImg=self.dataAry[indexPath.item];
    DetailViewController* detailVC=[[DetailViewController alloc]initWithObjectId:beaImg.objectId typeID:2];
    detailVC.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 返回顶部

//显示返回顶部按钮
- (void)showBackToTopBtn {
    if (nil == _backToTopBtn) {
        _backToTopBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 36 - 20, self.view.frame.size.height - 20 - 36, 36, 36)];
        [_backToTopBtn setBackgroundImage:[UIImage imageNamed:@"back_to_top"] forState:UIControlStateNormal];
        [_backToTopBtn addTarget:self action:@selector(onBackToTopBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backToTopBtn];
        
    }
    else{
        [self.view bringSubviewToFront:_backToTopBtn];
    }
    
    _backToTopBtn.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        _backToTopBtn.alpha = 1.0;
    }];
}

//隐藏返回顶部按钮
- (void)hideBackToTopBtn {
    [UIView animateWithDuration:0.3 animations:^{
        _backToTopBtn.alpha = 0.0;
    }];
}

//返回顶部事件
- (void)onBackToTopBtnClick {
    [self.collectionView setContentOffset:CGPointMake(0, -self.collectionView.contentInset.top) animated:YES];
}

#pragma mark - MJRefresh上下拉加载

- (void)refresh {
    [YJProgressHUD showMessage:@"已是最新" inView:self.view];
    self.pageIndex = 1;
    [self requestData];
}

- (void)loadMore {
    self.pageIndex ++;
    [self requestData];
}

- (void)endRefreshing {
    if (_header) {
        [self.header endRefreshing];
    }
    if (_footer) {
        [self.footer endRefreshing];
    }
}

- (void)removedRefreshing {
    _header = nil;
    _footer = nil;
    self.collectionView.mj_header = nil;
    self.collectionView.mj_footer = nil;
}

- (void)showLoadMoreRefreshing {
    self.footer.hidden = NO;
}

- (void)hideLoadMoreRefreshing {
    self.footer.hidden = YES;
}

- (MJRefreshNormalHeader *)header {
    if (!_header) {
        __weak __typeof(self)weakSelf = self;
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong __typeof(self)self = weakSelf;
            [self refresh];
        }];
        self.collectionView.mj_header = _header;
    }
    return [self setRefreshNormalHeaderParameter:_header];
}

- (MJRefreshAutoNormalFooter *)footer {
    if (!_footer) {
        __weak __typeof(self)weakSelf = self;
        _footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            __strong __typeof(self)self = weakSelf;
            [self loadMore];
        }];
        self.collectionView.mj_footer = _footer;
    }
    return [self setRefreshAutoNormalFooterParameter:_footer];
}

#pragma mark - 懒加载

- (UICollectionView *)collectionView {
    if (!_collectionView) {
       
        //创建一屏的视图大小
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
- (CGFloat)itemHeightAtIndexPath:(NSIndexPath*)indexpath{
    ImgBea* beaImg=self.dataAry[indexpath.row];
    NSString* url=beaImg.imgUrl;
    /**
     *  参数1:图片URL
     *  参数2:imageView 宽度
     *  参数3:预估高度,(此高度仅在图片尚未加载出来前起作用,不影响真实高度)
     */
    NSURL* imgurl=[NSURL URLWithString:url];
    return [XHWebImageAutoSize imageHeightForURL:imgurl layoutWidth:self.layout.itemWidth estimateHeight:200];
}
- (WaterFallCollectionLayout *)layout{
    //先实例化一个层
    if (!_layout) {
        __weak typeof(self)weakSlef=self;
        _layout= [[WaterFallCollectionLayout alloc]initWithItemHeightBlock:^CGFloat(NSIndexPath *index) {
            return [weakSlef itemHeightAtIndexPath:index];
        }];
    }
    
    return _layout;
}
- (NSMutableArray *)dataAry {
    if (!_dataAry) {
        _dataAry = [NSMutableArray new];
    }
    return _dataAry;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
