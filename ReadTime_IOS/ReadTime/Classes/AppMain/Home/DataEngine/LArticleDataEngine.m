//
//  LArticleDataEngine.m
//  ReadTime
//
//  Created by ComeOnJian on 2017/4/17.
//  Copyright © 2017年 ComeOnJian. All rights reserved.
//

#import "LArticleDataEngine.h"

@implementation LArticleDataEngine

/**
 获取轮播图数据

 @param control <#control description#>
 @param responeBlock <#responeBlock description#>
 @return <#return value description#>
 */
+ (RTBaseDataEngine*)control:(NSObject *)control complete:(CompletionDataBlock)responeBlock{
    
    return [RTBaseDataEngine control:control callAPIWithServiceType:YAServiceYA path:@"classes/LArticle" param:nil requestType:RTAPIManagerRequestTypeGet alertType:DataEngineAlertType_None progressBlock:nil complete:responeBlock errorButtonSelectIndex:nil];
}

@end
