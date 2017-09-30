//
//  NSObject+RTNetWorkingAutoCancel.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "NSObject+RTNetWorkingAutoCancel.h"
#import <objc/runtime.h>
@implementation NSObject (RTNetWorkingAutoCancel)
- (RTNetworkingAutoCancelRequests*) networkingAutoCancelRequest{
    RTNetworkingAutoCancelRequests* requests=objc_getAssociatedObject(self, @selector(networkingAutoCancelRequest));
    if (requests==nil) {
        requests=[[RTNetworkingAutoCancelRequests alloc]init];
        objc_setAssociatedObject(self, @selector(networkingAutoCancelRequest), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requests;
}
@end
