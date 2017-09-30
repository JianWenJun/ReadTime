//
//  YANetworkingAutoCancelRequests.h
//  NetWorking
//
//  Created by Yasin on 16/4/27.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTBaseDataEngine.h"
@interface RTNetworkingAutoCancelRequests : NSObject
- (void)setEngine:(RTBaseDataEngine *)engine requestID:(NSNumber *)requestID;
- (void)removeEngineWithRequestID:(NSNumber *)requestID;
@end
