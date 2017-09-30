//
//  AlertUtil.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//


@interface AlertUtil : NSObject


/**
 单个按键的alertView

 @param title 标题
 @param message 内容信息
 @param comTitle 按键标题
 */
+ (void)presentAlertViewWithTitle:(NSString*)title message:(NSString*)message comfirmTitle:(NSString*)comTitle;


/**
 双按键的alertview

 @param title 标题
 @param message 内容信息
 @param comTitle 左标题
 @param cancelTitle 右标题
 @param distinct 按键颜色是否区分
 @param cancel 回调
 @param comfirm 回调
 */
+ (void)presentAlertViewWithTitle:(NSString *)title message:(NSString *)message comfirmTitle:(NSString *)comTitle cancelTitle:(NSString*)cancelTitle distinct:(BOOL)distinct cancel:(void(^)())cancel comfirm:(void(^)())comfirm;

/**
 *  任意多按键的 alert (alertView or ActionSheet)
 *
 *  @param title          标题
 *  @param message        内容
 *  @param actionTitles   按键标题数组
 *  @param preferredStyle  弹窗类型 alertView or ActionSheet
 *  @param handler        按键回调
 内置"取消"按键, buttonIndex 为0
 */
+ (void)presentAlertWithTitle:(NSString *)title message:(NSString *)message actionTitles:(NSArray *)actionTitles  preferredStyle:(UIAlertControllerStyle)preferredStyle handler:(void(^)(NSUInteger buttonIndex, NSString* buttonTitle))handler;


@end
