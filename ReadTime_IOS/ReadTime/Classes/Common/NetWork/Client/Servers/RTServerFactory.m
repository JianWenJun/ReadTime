//
//  RTServerFactory.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTServerFactory.h"
#import "LeServer.h"

@interface RTServerFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end
@implementation RTServerFactory

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static RTServerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RTServerFactory alloc] init];
    });
    return sharedInstance;
}

+ (NSString*)RTBaseAPI{
    return [[RTServerFactory sharedInstance]serviceWithType:YAServiceYA].apiBaseUrl;
}

+ (EnvironmentType)getEnvironmentType{
    return [[RTServerFactory sharedInstance] serviceWithType:YAServiceYA].environment;
}

+ (void)changeEnvironmentType:(EnvironmentType)environmentType{
    RTServerFactory *factory = [self sharedInstance];
    [factory.serviceStorage.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RTBaseServers *service = obj;
        service.environment = environmentType;
    }];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:environmentType] forKey:@"environmentType"];
}

- (RTBaseServers<RTBaseServiceProtocol>*)serviceWithType:(RTServiceType)type{
    if (self.serviceStorage[@(type)] == nil) {
        self.serviceStorage[@(type)] = [self newServiceWithType:type];
    }
    return self.serviceStorage[@(type)];
}

#pragma mark - private methods
- (RTBaseServers<RTBaseServiceProtocol> *)newServiceWithType:(RTServiceType)type
{
    RTBaseServers<RTBaseServiceProtocol> *service = nil;
    switch (type) {
        case YAServiceYA:
            service = [[LeServer alloc] init];
            break;
        case YAServiceYB:
            service = [[LeServer alloc] init];
            break;
        default:
            break;
    }
    return service;
}
#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}
@end
