//
//  CommmentAndCollectDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/28.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "CommmentAndCollectDataEngine.h"

@implementation CommmentAndCollectDataEngine


+ (RTBaseDataEngine *)control:(NSObject *)control
                     objectIDinCollect:(NSString*)objectID
                     complete:(CompletionDataBlock)responseBlock{
    
    NSString *whereParm=[NSString stringWithFormat:@"{\"desID\":\"%@\"}",objectID];
    NSDictionary *param = @{@"where":whereParm,
                            @"count":@(1),
                            @"limit":@(0)
                            };
    NSString* path=@"classes/Collect";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
    
}
+ (RTBaseDataEngine*)control:(NSObject *)control objectIDinComment:(NSString *)objectID complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"desID\":\"%@\"}",objectID];
    NSDictionary *param = @{@"where":whereParm,
                            @"count":@(1),
                            @"limit":@(20)
                            };
    NSString* path=@"classes/Comment";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}


+ (RTBaseDataEngine*)control:(NSObject *)control objectIDinCollect:(NSString *)objectID userID:(NSInteger)userID complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"desID\":\"%@\",\"userID\":%ld}",objectID,userID];
    NSDictionary *param = @{@"where":whereParm,
                            @"count":@(1),
                            @"limit":@(1)
                            };
    NSString* path=@"classes/Collect";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}

+ (RTBaseDataEngine *)control:(NSObject *)control objectIDinCollect:(NSString *)objectID userID:(NSInteger)userID artType:(NSInteger)typeID collectDes:(NSString*)collectDes complete:(CompletionDataBlock)responseBlock{
    NSDictionary *param=@{
                          @"desID":objectID,
                          @"userID":@(userID),
                          @"desTypeID":@(typeID),
                          @"CollectDes":collectDes
                          };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/Collect" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//取消收藏
+ (RTBaseDataEngine *)control:(NSObject *)control
      objectIDinCollectCancel:(NSString*)objectID//收藏的文字objectID
                     complete:(CompletionDataBlock)responseBlock{
//     NSString *whereParm=[NSString stringWithFormat:@"{\"desID\":\"%@\",\"userID\":%ld}",objectID,userID];
//    whereParm=[whereParm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"whereParm:%@",whereParm);
    
    NSString* path=[NSString stringWithFormat:@"classes/Collect/%@",objectID];
   
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:nil requestType:RTAPIManagerRequestTypeDelete alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}


//
//添加评论
+ (RTBaseDataEngine *)control:(NSObject *)control
            objectIDinComment:(NSString*)objectID
                     userName:(NSString*)username
                       userID:(NSInteger)userID
               commentContent:(NSString*)content
                     complete:(CompletionDataBlock)responseBlock{
    NSDictionary *param=@{
                          @"desID":objectID,
                          @"userName":username,
                          @"commentContent":content,
                          @"userID":@(userID)
                          };
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/Comment" param:param requestType:RTAPIManagerRequestTypePost alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//删除评论
+ (RTBaseDataEngine *)control:(NSObject *)control
      objectIDinCommentCancel:(NSString*)objectID//删除的评论objectID
                     complete:(CompletionDataBlock)responseBlock{
    NSString* path=[NSString stringWithFormat:@"classes/Comment/%@",objectID];
    
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:nil requestType:RTAPIManagerRequestTypeDelete alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}

//通过用户ID查找收藏记录
+ (RTBaseDataEngine *)control:(NSObject *)control
              userIDinCollect:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"userID\":%ld}",userID];
    NSDictionary *param = @{
                            @"where":whereParm
                            };
    NSString* path=@"classes/Collect";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//通过用户ID查找评论记录
+ (RTBaseDataEngine *)control:(NSObject *)control
              userIDinComment:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"userID\":%ld}",userID];
    NSDictionary *param = @{
                            @"where":whereParm
                            };
    NSString* path=@"classes/Comment";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
//通过用户ID查找发布文章记录
+ (RTBaseDataEngine *)control:(NSObject *)control
           userIDinPreArticle:(NSInteger)userID
                     complete:(CompletionDataBlock)responseBlock{
    NSString *whereParm=[NSString stringWithFormat:@"{\"userID\":%ld}",userID];
    NSDictionary *param = @{
                            @"where":whereParm
                            };
    NSString* path=@"classes/PreArticle";
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:path param:param requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responseBlock errorButtonSelectIndex:nil];
}
@end
