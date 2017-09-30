//
//  SlideViewController.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//管理轮播图的视图控制器
#import <UIKit/UIKit.h>
@class SlideView;
@class SlideArticle;

@interface SlideViewController : UIViewController

@property (strong,nonatomic)SlideView* sliderView;

- (instancetype)initWithFrame:(CGRect)frame andArt:(NSArray<SlideArticle*>*)slideArticles;// 初始化轮播图
@end
