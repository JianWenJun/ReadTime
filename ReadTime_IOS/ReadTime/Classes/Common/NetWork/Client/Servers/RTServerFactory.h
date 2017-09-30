//
//  RTServerFactory.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTBaseServers.h"

@interface RTServerFactory : NSObject
+ (instancetype)sharedInstance;
+ (NSString*)RTBaseAPI;
+ (EnvironmentType)getEnvironmentType;
+ (void)changeEnvironmentType:(EnvironmentType)environment;

- (RTBaseServers<RTBaseServiceProtocol>*)serviceWithType:(RTServiceType)type; 

@end
