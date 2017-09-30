//
//  RTTabItem.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTTabBarItem.h"

NSString *const RTTabBarItemAttributeTitle=@"ItemTitle";//标题
NSString *const RTTabBarItemAttributeNormalImageName=@"ItemNormalImageName";//正常显示时的图标
NSString *const RTTabBarItemAttributeSelectedImageName=@"ItemSelectedImageName";//被选中时的图标
NSString *const RTTabBarItemAttributeType=@"ItemType";//Item类型

@implementation RTTabBarItem

#pragma mark - 构造函数添加初始化操作
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark 初始化配置操作
/**
 初始化配置
 */
- (void)config{
    self.adjustsImageWhenHighlighted=NO;//点击效果取消
    self.imageView.contentMode=UIViewContentModeScaleAspectFit;
}

#pragma mark - 设置文字和图片的位置
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    CGSize titleSize=self.titleLabel.frame.size;
    
    CGSize imageSize=[self imageForState:UIControlStateNormal].size;
    if (imageSize.width != 0 && imageSize.height != 0) {
        CGFloat imageViewCenterY = CGRectGetHeight(self.frame) - 3 - titleSize.height - imageSize.height / 2 - 5;;
        self.imageView.center=CGPointMake(CGRectGetWidth(self.frame)/2, imageViewCenterY);
    }else{
        CGPoint imageViewCenter = self.imageView.center;
        imageViewCenter.x=CGRectGetWidth(self.frame)/2;
        imageViewCenter.y=(CGRectGetHeight(self.frame)-titleSize.height)/2;
        self.imageView.center=imageViewCenter;
    }
    
    CGPoint lableCenter=CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame) - 3 - titleSize.height / 2);
    self.titleLabel.center=lableCenter;
}

@end
