//
//  RTTabBar.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//


#import "RTTabBarItem.h"

@protocol RTTabBarDelegate <NSObject>
//提供中间Item 点击事件对外接口
- (void) tabBarDidSelectedRiseButton;

@end
@interface RTTabBar : UIView

@property (nonatomic,copy)NSArray<NSDictionary*> *tabBarItemAttributes;//Item的属性数组
@property (nonatomic,weak) id<RTTabBarDelegate>delegate;

//- (void)addTargte:(id)targte andAction:(SEL)action;

@end
