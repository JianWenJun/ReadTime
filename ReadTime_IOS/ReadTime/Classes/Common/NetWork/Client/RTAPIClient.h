//
//  RTAPIClient.h
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTAPIBaseRequestDataModel.h"
/**
 负责计算request，发起请求，作出回调，尽量不暴露底层实现
 */
@interface RTAPIClient : NSObject
+ (instancetype)shareInstance;

/**
 根据dataModel发起网络请求，并根据dataModel发起回调

 @return 网络请求task哈希值
 */
- (NSNumber*)callRequestWithRequestModel:(RTAPIBaseRequestDataModel*)requestModel;
/**
 取消网络请求
 */
- (void)cancelRequestWithRequestID:(NSNumber*)requestID;
- (void)cancelRequsetWIthRequestIDList:(NSArray<NSNumber*>*)requsetIDList;
@end
