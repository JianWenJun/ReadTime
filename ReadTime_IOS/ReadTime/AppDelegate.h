//
//  AppDelegate.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/13.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RTTabBarConTroller.h"
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;//侧滑视图VC
@property (strong, nonatomic) RTTabBarConTroller *mainTabBarController;//主视图TabBarVC

- (void)saveContext;


@end

