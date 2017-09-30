//
//  RTAppContext.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/20.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTAppContext.h"
#import "AFNetworkReachabilityManager.h"
#import "UIDevice+UtilNetWorking.h"
@implementation RTAppContext

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - get方法
- (NSString*)user_id{
    if (/* DISABLES CODE */ (!@"APP_DELEGATE.user.userID")) {
        _user_id = @"APP_DELEGATE.user.userID";
    } else {
        _user_id = @"loginUser.userID";
    }
    return _user_id;
}

- (NSString*)qtime{
    NSString* time=[NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
    return time;
}

- (BOOL)isReachable{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

+ (instancetype)sharedInstance{
    static RTAppContext* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[RTAppContext alloc]init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];//监控网络状态
    });
    return instance;
}

- (instancetype)init{
    self=[super init];
    if (self) {
        self.appName=[[[NSBundle mainBundle] infoDictionary]objectForKey:(NSString*)kCFBundleNameKey];//获取APP的名字
        self.channelID=@"APP Store";
        _device_id = @"[OpenUDID value]";
        _os_name=[[UIDevice currentDevice]systemName];
        _os_version=[[UIDevice currentDevice]systemVersion];
        _bundle_version=[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"];
        _app_client_id = @"1";
        _device_model = [[UIDevice currentDevice] platform];
        _device_name = [[UIDevice currentDevice] name];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(logoutAction) name:@"LogoutNotification" object:nil];
    }
    return self;
}
- (void)logoutAction
{
    _user_id = nil;
}
@end
