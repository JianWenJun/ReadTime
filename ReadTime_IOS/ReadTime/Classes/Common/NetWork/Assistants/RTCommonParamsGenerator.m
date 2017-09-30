//
//  RTCommonParamsGenerator.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTCommonParamsGenerator.h"
#import "RTAppContext.h"
#import "NSString+UtilNetWorking.h"
@implementation RTCommonParamsGenerator
//+ (NSDictionary*)commonParamsDictionary{
//    RTAppContext* context=[RTAppContext sharedInstance];
//    NSMutableDictionary* commonParams=[@{
//                                         @"device_id":context.device_id,
//                                         @"channel":context.channelID,
//                                         @"os_version":context.os_version,
//                                         @"api_version":context.bundle_version,
//                                         @"app_client_id":context.app_client_id,
//                                         @"device_model":context.device_model,
//                                         @"time":context.qtime
//                                         }mutableCopy];
//    if (![NSString isEmptyString:context.user_id]) {
//        commonParams[@"uid"]=context.user_id;
//    }
//    return commonParams;
//}
// @"Content-Type":@"application/json"
+ (NSDictionary*)commonParamsDictionary{
       NSMutableDictionary* commonParams=[@{
                                         @"X-LC-Id":@"xmWyNOsRP081U8MQgi1Kyhm2-gzGzoHsz",
                                         @"X-LC-Key":@"usbkl4Qjjei1l0T68JieGICD"
                                        
                                         }mutableCopy];
    return commonParams;
}
@end
