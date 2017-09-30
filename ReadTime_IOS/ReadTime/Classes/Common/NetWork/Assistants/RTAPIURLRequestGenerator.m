//
//  RTAPIURLRequestGenerator.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/3/19.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//
//根据datamodel生产URLRequest
#import "RTAPIURLRequestGenerator.h"
#import "AFURLRequestSerialization.h"
#import "RTServerFactory.h"
#import "RTCommonParamsGenerator.h"
#import "NSString+UtilNetworking.h"
static NSTimeInterval RTNetWorkingTimeOutSeconds=20.0f;

@interface RTAPIURLRequestGenerator ()
@property (strong,nonatomic)AFHTTPRequestSerializer* httpRequestSerializer;
@end
@implementation RTAPIURLRequestGenerator

/**
 生成一个单例

 @return <#return value description#>
 */
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static RTAPIURLRequestGenerator *instace=nil;
    dispatch_once(&onceToken, ^{
        instace=[[RTAPIURLRequestGenerator alloc]init];
    });
    return instace;
}
-(NSMutableURLRequest*)generateWithDataModel:(RTAPIBaseRequestDataModel *)dataModel{
    
    RTBaseServers* service=[[RTServerFactory sharedInstance]serviceWithType:dataModel.serviceType];
    //公共参数
    NSMutableDictionary* commonParams=[NSMutableDictionary dictionaryWithDictionary:[RTCommonParamsGenerator commonParamsDictionary]];
    //请求参数
//    [commonParams addEntriesFromDictionary:dataModel.parameters];
    if (![NSString isEmptyString:service.privateKey] ) {
        /**
         *  每个公司的签名方法不同，可以根据自己的设计进行修改，这里是将privateKey放在参数里面，然后将所有的参数和参数名转成字符串进行MD5，将得到的MD5值放进commonParams，上传的时候再讲privateKey从commonParams移除
         */
        //        commonParams[@"private_key"] = service.privateKey;
        //        NSString *signature = [YASignatureGenerator sign:commonParams];
        //        commonParams[@"sign"] = signature;
        //        [commonParams removeObjectForKey:@"private_key"];
    }
    NSString* urlString=[self URLStringWithServiceURl:service.apiBaseUrl path:dataModel.apiMethodPath];
    NSLog(@"urlString:%@",urlString);
    NSError* error;
    NSMutableURLRequest* request;
    
    if (dataModel.requestType==RTAPIManagerRequestTypeGet) {
        [commonParams setObject:@"application/json" forKey:@"Content-Type"];
        request=[self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:dataModel.parameters error:&error];
    }else if (dataModel.requestType == RTAPIManagerRequestTypePost){
        if (dataModel.parameters==nil) {
            //只传文件
            request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:dataModel.parameters error:&error];
            [commonParams setObject:dataModel.mimeType forKey:@"Content-Type"];//移除默认的
            [request setHTTPBody:dataModel.dataFilePath];
        }else{
            [commonParams setObject:@"application/json" forKey:@"Content-Type"];
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataModel.parameters
                                                               options:0
                                                                 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }else if (dataModel.requestType == RTAPIManagerRequestTypePostUpload){
//        NSString* value=[NSString stringWithFormat:@"%@;multipart/form-data",dataModel.mimeType];
         [commonParams setObject:dataModel.mimeType forKey:@"Content-Type"];//移除默认的
         request=[self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dataModel.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            if (dataModel.dataFilePath!=nil) {
                
                NSString* name=dataModel.dataName?dataModel.dataName:@"data";
                NSString *fileName = dataModel.filename?dataModel.filename:@"data.zip";
//                NSLog(@"fileName:%@,name:%@",fileName,name);
                NSString *mimeType = dataModel.mimeType?dataModel.mimeType:@"application/zip";
                NSError* error;
                [formData appendPartWithFileData:dataModel.dataFilePath name:@"file" fileName:fileName mimeType:mimeType];
            }
        } error:&error];
    }else if (dataModel.requestType == RTAPIManagerRequestTypePut){
        [commonParams setObject:@"application/json" forKey:@"Content-Type"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataModel.parameters
                                                           options:0
                                                             error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
             [request setHTTPMethod:@"PUT"];
        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }else if (dataModel.requestType == RTAPIManagerRequestTypeDelete){
        [commonParams setObject:@"application/json" forKey:@"Content-Type"];
         request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
          [request setHTTPMethod:@"DELETE"];
    }else if (dataModel.requestType == RTAPIManagerRequestTypePostUserInfo){
        [commonParams setObject:@"application/json" forKey:@"Content-Type"];
        [commonParams setObject:[UserConfig getSessionTocken] forKey:@"X-LC-Session"];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataModel.parameters
                                                           options:0
                                                             error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"PUT"];
        [request setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    }

    //添加请求头
//    [request re]
    [commonParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [request addValue:obj forHTTPHeaderField:key];
    }];
    if (error||request==nil) {
        DELog(@"NSMutableURLRequests生成失败：\n---------------------------\n\
              urlString:%@\n\
              \n---------------------------\n",urlString);
        return nil;
    }
    request.timeoutInterval=RTNetWorkingTimeOutSeconds;
    return request;
}
#pragma mark - 私有方法
- (NSString*)URLStringWithServiceURl:(NSString*)serviceUrl path:(NSString*)path{
    NSURL *fullUrl=[NSURL URLWithString:serviceUrl];
    if (![NSString isEmptyString:path]) {
//        path=[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        fullUrl=[NSURL URLWithString:path relativeToURL:fullUrl];
    }
    if (fullUrl == nil) {
        DELog(@"YAAPIURLRequestGenerator--URL拼接错误:\n---------------------------\n\
              apiBaseUrl:%@\n\
              urlPath:%@\n\
              \n---------------------------\n",serviceUrl,path);
        return nil;
    }
    return [fullUrl absoluteString];
}

- (AFHTTPRequestSerializer*)httpRequestSerializer{
    if (_httpRequestSerializer==nil) {
        _httpRequestSerializer=[AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval=RTNetWorkingTimeOutSeconds;
        _httpRequestSerializer.cachePolicy=NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}
@end
