//
//  RTTabBar.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTTabBar.h"
#import "LeftSlideViewController.h"
#import "RTTabBarConTroller.h"
//扩展
@interface RTTabBar()

@property(strong,nonatomic) NSMutableArray *tabBarItems;//底部Items

@end



@implementation RTTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

/**
 添加Tabbar上部分的图片
 */
- (void)config{
    self.backgroundColor=[UIColor whiteColor];
    UIImageView *topLine=[[UIImageView alloc]initWithFrame:CGRectMake(0, -5, SCREEN_WIDTH, 5)];
    topLine.image=[UIImage imageNamed:@"tapbar_top_line"];
    [self addSubview:topLine];
}

/**
 设置tab的选项卡显示第index个

 @param index 第几个tab
 */
- (void)setSelectedIndex:(NSInteger)index{

    for (RTTabBarItem *item in self.tabBarItems) {
        if (item.tag ==index) {
            item.selected=YES;
        }else{
            item.selected=NO;
        }
    }
    UIWindow *keyWindow=[[[UIApplication sharedApplication]delegate] window];
    //获取tabBarController, 并设置选项卡
    LeftSlideViewController* lSVc=(LeftSlideViewController*)keyWindow.rootViewController;
    RTTabBarConTroller *tabBarController=(RTTabBarConTroller*)lSVc.mainVC;
    if (tabBarController) {
        tabBarController.selectedIndex=index;
    }
}

/**
 设置底部tab点击事件

 @param sender 目标item
 */
- (void)itemSelected:(RTTabBarItem *)sender  {
//    NSLog(@"name----------%@",name);
    if (sender.tabBarItemType !=RTTabBarItemRise) {
        [self setSelectedIndex:sender.tag];
    } else {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
                [self.delegate tabBarDidSelectedRiseButton];
            }
        }
    }
}

/**
 设置TabBar的TabBarItem及其属性

 @param tabBarItemAttributes 属性数组
 */
- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes{
    _tabBarItemAttributes=tabBarItemAttributes.copy;
    NSAssert(_tabBarItemAttributes.count>2,@"item count must more than 2");
    CGFloat normalItemWidth = (SCREEN_WIDTH * 3 / 4) / (_tabBarItemAttributes.count - 1);
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    CGFloat publishItemWidth = (SCREEN_WIDTH / 4);
    
    NSInteger itemTag = 0;
    BOOL passedRiseItem = NO;
    
    _tabBarItems=[NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    for (id item in _tabBarItemAttributes) {
        NSDictionary * itemDict=(NSDictionary *)item;
        RTTabBarItemType type=[itemDict[RTTabBarItemAttributeType] integerValue];
        
        CGRect frame = CGRectMake(itemTag * normalItemWidth + (passedRiseItem ? publishItemWidth : 0), 0, type == RTTabBarItemRise ? publishItemWidth : normalItemWidth, tabBarHeight);
        
        RTTabBarItem *tabBarItem=[self tabBarItemWithFrame:frame
                                                    title:itemDict[RTTabBarItemAttributeTitle]
                                           norMalImageName:itemDict[RTTabBarItemAttributeNormalImageName]
                                         selectedImageName:itemDict[RTTabBarItemAttributeSelectedImageName]
                                            tabBarItemType:type];
        if (itemTag==0) {
            tabBarItem.selected=YES;
        }
        //添加点击事件
        [tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
        if (tabBarItem.tabBarItemType!=RTTabBarItemRise) {
            tabBarItem.tag=itemTag;
            itemTag++;
        }else{
            passedRiseItem=YES;
        }
        //将item添加到tabbar中
        [_tabBarItems addObject:tabBarItem];
        [self addSubview:tabBarItem];
    }
}

/**
 根据提供的属性设置item

 @param frame <#frame description#>
 @param title <#title description#>
 @param norMalImageName <#norMalImageName description#>
 @param selectedImageName <#selectedImageName description#>
 @param tabBarItemType <#tabBarItemType description#>
 @return <#return value description#>
 */
- (RTTabBarItem*)tabBarItemWithFrame:(CGRect)frame title:(NSString*)title norMalImageName:(NSString*)norMalImageName
                   selectedImageName:(NSString *)selectedImageName tabBarItemType:(RTTabBarItemType)tabBarItemType{
    RTTabBarItem *tabBarItem=[[RTTabBarItem alloc]initWithFrame:frame];
    [tabBarItem setTitle:title forState:UIControlStateNormal];
    [tabBarItem setTitle:title forState:UIControlStateSelected];
    tabBarItem.titleLabel.font=[UIFont systemFontOfSize:10];
    UIImage *normalImage=[UIImage imageNamed:norMalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [tabBarItem setImage:normalImage forState:UIControlStateNormal];
    [tabBarItem setImage:selectedImage forState:UIControlStateSelected];
    [tabBarItem setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [tabBarItem setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];
    tabBarItem.tabBarItemType = tabBarItemType;
    return tabBarItem;
    
}
@end
