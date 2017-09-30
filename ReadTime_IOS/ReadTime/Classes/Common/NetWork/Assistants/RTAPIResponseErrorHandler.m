//
//  RTAPIResponseErrorHandler.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "RTAPIResponseErrorHandler.h"
#import "Error.h"
@implementation RTAPIResponseErrorHandler
+ (void)errorHandlerWithRequestDataModel:(RTAPIBaseRequestDataModel *)requestDataModel responseURL:(NSURLResponse *)responseURL responseObject:(id)responseObject error:(NSError *)error errorHandler:(void (^)(NSError *))errorHandler{
    
    if (error) {
        //处理错误
        if (errorHandler) {
            errorHandler(error);
        }
        Error* error=[Error mj_objectWithKeyValues:responseObject];
        if (error) {
            [YJProgressHUD showMsgWithoutView:error.error];
        }
        NSLog(@"错误回应：%@",responseObject);
        
    }else{
        NSInteger errorCode=200;
        NSString* message=@"网络错误";
        if (![responseObject isKindOfClass:[NSDictionary class]]&&![responseObject isKindOfClass:[NSArray class]]) {
            errorCode=-800;
        }else{
            //其他的错误解析逻辑，包含重新暂时不返回回调重新发起网络请求
            //注意只修改errorCode和message就行了，下面会统一生成新的error
            //如果是重新发起网络请求，发起网络请求后就直接return，不再执行下面的逻辑
        }
        if (errorCode!=200) {
//            统一生成新的error
            error=[[NSError alloc]initWithDomain:NSCocoaErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey:message,@"data":responseObject,@"URL":responseURL.URL.absoluteString}];
            if (errorHandler) {
                errorHandler(error);
            }
        }else{
            if (errorHandler) {
                errorHandler(nil);
            }
            
        }
    }
}
@end
