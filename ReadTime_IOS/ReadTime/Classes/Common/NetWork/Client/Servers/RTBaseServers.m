//
//  RTBaseServers.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTBaseServers.h"

@interface RTBaseServers ()
@property(weak,nonatomic)id<RTBaseServiceProtocol>child;
@property(strong,nonatomic)NSString* customApiBaseUri;
@end
@implementation RTBaseServers
@synthesize privateKey=_privateKey,apiBaseUrl=_apiBaseUrl;
- (instancetype)init{
    self=[super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(RTBaseServiceProtocol)]) {
            self.child=(id<RTBaseServiceProtocol>)self;
#ifdef YA_BUILD_FOR_RELEASE
            //优先宏定义正式环境
            self.environment = EnvironmentTypeRelease;
#else
//            手动切换环境后把设置保存
            NSNumber *type=[[NSUserDefaults standardUserDefaults]objectForKey:@"environmentType"];
            if (type) {
                self.environment=(EnvironmentType)[type integerValue];
            }else{
#ifdef YA_BUILD_FOR_DEVELOP
                self.environment = EnvironmentTypeDevelop;
#elif defined YA_BUILD_FOR_TEST
                self.environmentType = EnvironmentTypeTest;
#elif defined YA_BUILD_FOR_PRERELEASE
                self.environmentType = EnvironmentTypePreRelease;
#elif defined YA_BUILD_FOR_HOTFIX
                self.environmentType = EnvironmentTypeHotFix;
#endif
            }
#endif
        }else{
            NSAssert(NO, @"子类没有实现协议");
        }
    }
    return self;
}


- (void)setEnvironment:(EnvironmentType)environment{
    if (environment == EnvironmentTypeCustom) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.apiBaseUrl forKey:NSStringFromClass([self class])];
        }
    }else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NSStringFromClass([self class])];
    }
    _environment=environment;
    _apiBaseUrl=nil;
}

- (NSString *)privateKey
{
    if (!_privateKey) {
        _privateKey = @"abcdefghijklmn";
    }
    return _privateKey;
}
- (NSString *)apiBaseUrl
{
    if (_apiBaseUrl == nil) {
        switch (self.environment) {
            case EnvironmentTypeDevelop:
                _apiBaseUrl = self.child.developApiBaseUrl;
                break;
            case EnvironmentTypeTest:
                _apiBaseUrl = self.child.testApiBaseUrl;
                break;
            case EnvironmentTypePreRelease:
                _apiBaseUrl = self.child.prereleaseApiBaseUrl;
                break;
            case EnvironmentTypeHotFix:
                _apiBaseUrl = self.child.hotfixApiBaseUrl;
                break;
            case EnvironmentTypeRelease:
                _apiBaseUrl = self.child.releaseApiBaseUrl;
                break;
            case EnvironmentTypeCustom:
                _apiBaseUrl = self.customApiBaseUri;
                break;
            default:
                break;
        }
    }
    return _apiBaseUrl;
}
- (NSString *)customApiBaseUrl{
    if (!_customApiBaseUri) {
        _customApiBaseUri = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
    }
    return _customApiBaseUri;
}
@end
