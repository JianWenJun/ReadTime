//
//  SlideView.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/18.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 设置轮播View数据源（设置数据，处理点击事件）

@protocol SlideViewDataSource <NSObject>

@required

/**
 指定轮播图的项目数

 @return <#return value description#>
 */
- (NSInteger)numberOfItemsInSliderView;
@optional

/**
 指定牵引位置的图片

 @param index 牵引值
 @return <#return value description#>
 */
- (UIImage*)imageForSliderAtIndex:(NSInteger)index;

/**
 指定牵引位置的标题

 @param index <#index description#>
 @return <#return value description#>
 */
- (NSString*)titleForSliderAtIndex:(NSInteger)index;

/**
 指定牵引位置的点击事件

 @param index <#index description#>
 */
- (void)touchUpForSliderAtIndex:(NSInteger)index;
@end

@interface SlideView : UIView
@property (weak,nonatomic)id<SlideViewDataSource>dataSource;
@property (assign,nonatomic)NSTimeInterval interval;//时间轮播

//@property (assign,nonatomic)NSInteger contentInsetY;

/**
 构建SliderView
 */
- (void)buildSliderView;

- (void)stopSliding;
- (void)startSliding;

- (void)setImageURL:(NSURL*)imageUrl atIndex:(NSInteger)index;
@end
