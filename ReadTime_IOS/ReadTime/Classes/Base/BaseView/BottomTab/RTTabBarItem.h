//
//  RTTabItem.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

//定义tabbarItem的类型
typedef NS_ENUM(NSUInteger,RTTabBarItemType) {
    RTTabBarItemNormal=0,//正常状态
    RTTabBarItemRise=1,//上浮状态
};
//声明属性
extern NSString *const RTTabBarItemAttributeTitle;//标题
extern NSString *const RTTabBarItemAttributeNormalImageName;//正常显示时的图标
extern NSString *const RTTabBarItemAttributeSelectedImageName;//被选中时的图标
extern NSString *const RTTabBarItemAttributeType;//Item类型
@interface RTTabBarItem : UIButton
 @property(nonatomic,assign)RTTabBarItemType tabBarItemType;
@end
