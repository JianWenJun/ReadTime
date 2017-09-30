//
//  UpFeedBackDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/23.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "UpDataEngine.h"

@implementation UpDataEngine
+ (RTBaseDataEngine *)control:(NSObject *)control
                feedBackModel:(FeedBackModel*)model
                     complete:(CompletionDataBlock)responseBlock{
    NSDictionary* param=model.mj_keyValues;
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/FeedBack" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
+ (RTBaseDataEngine*)control:(NSObject *)control
                dataFilePath:(NSData *)dataFilePath
                    fileName:(NSString *)fileName
                    mimeType:(NSString *)mimeType
                    complete:(CompletionDataBlock)responseBlock{
    NSString* path=[NSString stringWithFormat:@"files/%@",fileName];
    return [RTBaseDataEngine control:control uploadAPIWithServiceType:YAServiceYA path:path param:nil dataFilePath:dataFilePath dataName:nil fileName:fileName mimeType:mimeType requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None uploadProgressBlock:nil downloadProgressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//更改用户信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     userName:(NSString*)name
                         sign:(NSString*)sign
                     complete:(CompletionDataBlock)responseBlock{
    NSDictionary* param=@{
                          @"username":name,
                          @"signature":sign
                          };
    NSString* path=[NSString stringWithFormat:@"classes/_User/%@",[UserConfig getUserObjectID]];
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypePostUserInfo alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//提交文章信息
+ (RTBaseDataEngine *)control:(NSObject *)control
                     artModel:(ArticleModel*)model
                     complete:(CompletionDataBlock)responseBlock{
    NSDictionary* param=model.mj_keyValues;
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/PreArticle" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}

@end
