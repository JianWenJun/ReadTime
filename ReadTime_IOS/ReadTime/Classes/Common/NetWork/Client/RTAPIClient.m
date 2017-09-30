//
//  RTAPIClient.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTAPIClient.h"
#import "AFURLSessionManager.h"
#import "RTAPIURLRequestGenerator.h"
#import "RTAPIResponseErrorHandler.h"
@interface RTAPIClient()
//AFNetworking stuff
@property (strong,nonatomic)AFURLSessionManager* sessionManager;
//根据requestid，存放task
@property (strong,nonatomic)NSMutableDictionary* dispatchTable;
@property (strong,nonatomic)NSNumber* recordedRequestId;
//根据requestID，存放requestModel
@property (strong,nonatomic)NSMutableDictionary* requestModelDict;

@end
@implementation RTAPIClient
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static RTAPIClient* sharedInstance=nil;
    dispatch_once(&onceToken, ^{
        sharedInstance=[[RTAPIClient alloc]init];
    });
    return sharedInstance;
}

/**
 根据dataModel发起网络请求，并根据datamodel发起回调

 @param requestModel <#requestModel description#>
 @return 网络请求的task哈希值
 */
- (NSNumber*)callRequestWithRequestModel:(RTAPIBaseRequestDataModel *)requestModel{
    
    NSMutableURLRequest* request=[[RTAPIURLRequestGenerator shareInstance]generateWithDataModel:requestModel];
    if (requestModel.requestType==1) {
        [ request.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//                    NSLog(@"postkey:%@,postvalues:%@",key,obj);
                }];
    }
    typeof(self) __weak weakSelf = self;
    AFURLSessionManager* sessionManager=self.sessionManager;
    NSURLSessionDataTask* task=[sessionManager dataTaskWithRequest:request
                                                    uploadProgress:requestModel.uploadProgress
                                                  downloadProgress:requestModel.downloadProgress
                                                 completionHandler:^(NSURLResponse * _Nonnull response,
                                                                     id  _Nullable responseObject,
                                                                     NSError * _Nullable error ){
                                                     if (task.state==NSURLSessionTaskStateCanceling) {
                                                         
                                                     }else{
                                                         NSNumber* requestId=[NSNumber numberWithUnsignedInteger:task.hash];
                                                         [weakSelf.dispatchTable removeObjectForKey:requestId];
                                                         //在这里做网络错误的解析，只是整理成error(包含重新发起请求，比如重新获取签名后再次请求),不做任何UI处理(包含reload，常规reload不在这里处理)，
                                                         //解析完成后通过调用requestModel.responseBlock进行回调
                                                         [RTAPIResponseErrorHandler
                                                          errorHandlerWithRequestDataModel:requestModel
                                                          responseURL:response
                                                          responseObject:responseObject
                                                          error:error
                                                          errorHandler:^(NSError *newError) {
                                                              requestModel.responseBlock(responseObject,newError);
                                                          }];
                                                     }
                                                 }];
    [task resume];
//    request.HTTPBodyStream
 
//    [request.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//        NSLog(@"qqkey:%@,qqvalues:%@",key,obj);
//    }];
    NSNumber* requestID=[NSNumber numberWithUnsignedInteger:task.hash];
    return requestID;
                                
}

/**
 取消网络请求
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionDataTask* task=[self.dispatchTable objectForKey:requestID];
    [task cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequsetWIthRequestIDList:(NSArray<NSNumber *> *)requsetIDList{
    typeof(self) __weak weakSelf = self;
    [requsetIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask* task=[weakSelf.dispatchTable objectForKey:obj];
        [task cancel];
    }];
    [self.dispatchTable removeObjectsForKeys:requsetIDList];
}


#pragma mark - getters and setters
- (AFURLSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [self getCommonSessionManager];
        
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}
- (AFURLSessionManager*)getCommonSessionManager{
//    缓存如果设定本地磁盘就会为我们自动进行持久化,储存于sqlite中
    NSURLCache* UrlCache=[[NSURLCache alloc]initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:40 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:UrlCache];
    NSURLSessionConfiguration* configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource=60;
    AFURLSessionManager* sessionManager=[[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    return sessionManager;
}
- (NSMutableDictionary *)dispatchTable{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

@end
