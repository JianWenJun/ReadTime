//
//  SlideView.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/18.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "SlideView.h"
#import "GradientView.h"
#import "UIImageView+WebCache.h"
/**
 扩展
 */
@interface SlideView()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView* scrollView;
@property (strong,nonatomic)UIPageControl* pageControl;
@property (strong,nonatomic)UIButton* button;

@property (assign,nonatomic)CGSize viewSize;
@property (assign,nonatomic)NSUInteger pageIndex;
@property (strong,nonatomic)NSTimer* timer;

@property (assign,nonatomic)NSInteger imageCount;
@property (strong,nonatomic)NSMutableArray<UIImageView*>* imageViwes;

@property (assign,nonatomic)BOOL singleImageMode;
@end
@implementation SlideView

- (void)dealloc{
    
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter]removeObserver:self];//注销观察者
}

#pragma mark - 初始化工作
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.viewSize=frame.size;
    }
    return self;
}

- (void)buildSliderView{
    [self loadImages];
    [self loadContents];
    [self loadButton];
    [self addSubview:self.scrollView];
    [self bringSubviewToFront:self.pageControl];
    [self startSliding];
    //需要改变，当当前ViewControll不可见时停止，可见时候开始。
    NSNotificationCenter *nc=[NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(stopSliding)
               name:UIApplicationWillResignActiveNotification
             object:nil];
    [nc addObserver:self selector:@selector(startSliding)
               name:UIApplicationDidBecomeActiveNotification
             object:nil];
}

- (void)loadImages{
    for (int i=0;i<self.imageCount; i++) {
        //设置图片的宽高位置
        UIImageView* imageView = [[UIImageView alloc]
                                  initWithFrame:CGRectMake(i * (self.viewSize.width),
                                                0, self.viewSize.width,self.viewSize.height)];
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        imageView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.3];
        [self.scrollView addSubview:imageView];
        [self.imageViwes addObject:imageView];
        
        //委托获取图片
        if ([self.dataSource respondsToSelector:@selector(imageForSliderAtIndex:)]) {
            UIImage *image=[self.dataSource imageForSliderAtIndex:i];
            if (image!=nil) {
                imageView.image=image;
            }
        }
    }
}

- (void)loadContents{
    if (![self.dataSource respondsToSelector:@selector(titleForSliderAtIndex:)]) {
        return;
    }
    for (int i=0; i<self.imageCount; i++) {
        NSString* content=[self.dataSource titleForSliderAtIndex:i];
        if (content==nil) {
            continue;
        }
        GradientView* gradientView=[[GradientView alloc]
                                   initWithFrame:CGRectMake(i*self.viewSize.width, 0, self.viewSize.width,
                                                            self.viewSize.height)];
        gradientView.gradientLayer.colors = [NSArray
                                             arrayWithObjects:(id)[[UIColor clearColor] CGColor],
                                             (id)[[UIColor colorWithWhite:0 alpha:0.7] CGColor], nil];
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(10, 120,
                                                                self.viewSize.width - 20, 50)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:20 weight:0.3];
        label.shadowOffset = CGSizeMake(0, 1);
        label.shadowColor = [UIColor blackColor];
        label.numberOfLines = 2;
        label.text = content;
//        [label sizeToFit];
        label.textAlignment=NSTextAlignmentCenter;
        [gradientView addSubview:label];
      
        [self.scrollView addSubview:gradientView];
    }
}

- (void)loadButton{
    self.button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height)];
    self.button.titleLabel.text=@"";
    [self.button addTarget:self action:@selector(slideClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.button];
}
#pragma mark - 重写get方法
- (UIPageControl*)pageControl{
    if (_pageControl==nil) {
        _pageControl=[[UIPageControl alloc]init];
        if (self.singleImageMode) {
            return _pageControl;
        }
        _pageControl.numberOfPages=self.imageCount;
        CGSize pageSize=[_pageControl sizeForNumberOfPages:self.imageCount];
        _pageControl.bounds=CGRectMake(0, 0, self.viewSize.width, pageSize.height);
        _pageControl.center=CGPointMake(self.center.x, self.viewSize.height-15);
        _pageControl.pageIndicatorTintColor=[UIColor colorWithWhite:1 alpha:0.3];
        _pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
        
        [_pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_pageControl];

    }
    return _pageControl;
   }

- (UIScrollView*)scrollView{
    if (_scrollView==nil) {
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.viewSize.width, self.viewSize.height)];
        [_scrollView setContentSize:CGSizeMake(self.viewSize.width*self.imageCount, self.viewSize.height)];
        [_scrollView setPagingEnabled:YES];
        //禁止反弹效果，隐藏滚动条
        [_scrollView setBounces:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        
        _scrollView.delegate=self;
        
    }
    return _scrollView;
}
- (BOOL)singleImageMode{
    return self.imageCount<=1;
}
- (NSTimeInterval)interval{
    if (_interval==0) {
        _interval=3;
    }
    return _interval;
}
- (CGSize)viewSize{
    return self.bounds.size;
}
- (NSUInteger)pageIndex
{
    return self.scrollView.contentOffset.x / self.viewSize.width;
}
- (NSInteger)imageCount{
    if (_imageCount == 0) {
        _imageCount = [self.dataSource numberOfItemsInSliderView];
    }
    return _imageCount;
}
- (NSMutableArray<UIImageView*>*)imageViwes{
    if (_imageViwes==nil) {
        _imageViwes=[NSMutableArray array];
    }
    return _imageViwes;
}

#pragma mark - 轮播图点击事件（在上面添加button）
- (void)slideClicked{
    if ([self.dataSource respondsToSelector:@selector(touchUpForSliderAtIndex:)]) {
         [self.dataSource touchUpForSliderAtIndex:self.pageIndex];
    }
}
#pragma mark - 定时跳转
- (void)interValtriggered{
//    NSLog(@"跳转中------");
    int pageIndex=(int)((self.pageControl.currentPage+1)%self.imageCount);
    self.pageControl.currentPage=pageIndex;
    [self pageChanged:self.pageControl];
}
- (void)pageChanged:(UIPageControl*)pageControl{
    CGFloat offsetX=pageControl.currentPage*self.viewSize.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
#pragma mark - 实现ScrollView代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startSliding];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage=self.pageIndex;
}
#pragma mark - 对外提供的公共方法
- (void)setImageURL:(NSURL*)imageUrl atIndex:(NSInteger)index{
    UIImageView* imageView=self.imageViwes[index];
    if (imageView!=nil) {
        [imageView setIsRound:NO withSize:CGSizeZero];
        [imageView sd_setImageWithURL:imageUrl];
        [imageView setNeedsDisplay];
        [self setNeedsDisplay];
        [self.scrollView setNeedsDisplay];
    }
}

- (void)stopSliding{
    [self.timer invalidate];
}
-(void)startSliding{
    if (self.singleImageMode) {
        return;
    }
    if (!self.timer.isValid) {
        self.timer=[NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(interValtriggered) userInfo:nil repeats:YES];
    }
}
@end
