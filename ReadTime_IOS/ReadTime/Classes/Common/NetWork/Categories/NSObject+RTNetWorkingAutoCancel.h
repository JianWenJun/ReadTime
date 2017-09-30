//
//  NSObject+RTNetWorkingAutoCancel.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/21.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTNetworkingAutoCancelRequests.h"
@interface NSObject (RTNetWorkingAutoCancel)
/**
 将networkingRequestArray绑定到NSObject，当NSObject释放时networkingRequestArray也会释放
 *  networkingRequestArray存放requestid，当networkingRequestArray释放的时候，根据requestid取消没有返回的网络请求
 */
@property(strong,nonatomic,readonly)RTNetworkingAutoCancelRequests* networkingAutoCancelRequest;
@end
