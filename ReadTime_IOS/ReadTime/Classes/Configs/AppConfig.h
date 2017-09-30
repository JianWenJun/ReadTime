//
//  AppConfig.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/14.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#ifndef AppConfig_h
#define AppConfig_h
//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))
// 屏幕高度
#define SCREEN_HEIGHT         [[UIScreen mainScreen] bounds].size.height
// 屏幕宽度
#define SCREEN_WIDTH          [[UIScreen mainScreen] bounds].size.width
#define SCREEN_SIZE           [[UIScreen mainScreen] bounds].size

#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
#define ViewBackgroundColor UIColorFromHex(0xf5f5f5) //界面View背景颜色
#define StatusBarStyle UIStatusBarStyleLightContent //状态栏样式
#define UIToneTextColor UIColorFromHex(0xffffff) //UI整体文字色调 与背景颜色对应
#define UIToneBackgroundColor UIColorFromHex(0x00bd8c) //UI整体背景色调 与文字颜色一一对应
#define circleCellPhotosWH ((SCREEN_WIDTH-2*10)-2*5)/3
//返回安全的字符串
#define kSafeString(str) str.length > 0 ? str : @""


/**
 *  获取iOS版本
 */
#define IOS_VERSION [UIDevice currentDevice].systemVersion

//#define isiOS10 ([[[[[UIDevice currentDevice] systemVersion] substringToIndex:1] stringByAppendingString:@"0"] intValue] == 10)

#define isiOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)

/*! 大于8.0 */
#define IOS8x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


// 获取沙盒 Document
#define RT_PathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

// 获取沙盒 Cache
#define RT_PathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

#define RT_SharedApplication [UIApplication sharedApplication]

#define RT_getDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

#endif /* AppConfig_h */
